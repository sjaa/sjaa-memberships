require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  setup do
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      signup_completed: true
    )
    
    @membership = Membership.new(
      person: @person,
      start: Date.current.beginning_of_month,
      term_months: 12,
      ephemeris: false
    )
  end

  test 'valid membership with required attributes' do
    assert @membership.valid?
    @membership.save!
    assert_not_nil @membership.end
  end

  test 'membership belongs to person' do
    @membership.save!
    assert_equal @person, @membership.person
    assert_includes @person.memberships, @membership
  end

  test 'end date is calculated on save' do
    @membership.save!
    expected_end = (@membership.start + @membership.term_months.months).end_of_month
    assert_in_delta expected_end.to_f, @membership.end.to_f, 1 # Within 1 second tolerance
  end

  test 'end date updates when start or term_months changes' do
    @membership.save!
    original_end = @membership.end
    
    @membership.update!(term_months: 24)
    expected_end = (@membership.start + 24.months).end_of_month
    assert_in_delta expected_end.to_f, @membership.end.to_f, 1 # Within 1 second tolerance
    assert_not_equal original_end, @membership.end
  end

  test 'lifetime membership has nil end date' do
    @membership.term_months = nil
    @membership.save!
    assert_nil @membership.end
  end

  test 'is_active? returns true for current membership' do
    @membership.start = 1.month.ago
    @membership.term_months = 12
    @membership.save!
    
    assert @membership.is_active?
  end

  test 'is_active? returns false for expired membership' do
    @membership.start = 2.years.ago
    @membership.term_months = 12
    @membership.save!
    
    assert_not @membership.is_active?
  end

  test 'is_active? returns true for lifetime membership' do
    @membership.start = Date.current
    @membership.term_months = nil
    @membership.save!
    
    assert @membership.is_active?
  end

  test 'is_active? returns true for future membership' do
    @membership.start = 1.month.from_now
    @membership.term_months = 12
    @membership.save!
    
    # Current implementation considers future memberships as active
    assert @membership.is_active?
  end

  test 'term_years calculation' do
    @membership.term_months = 12
    assert_equal 1, @membership.term_years
    
    @membership.term_months = 24
    assert_equal 2, @membership.term_years
    
    @membership.term_months = nil
    assert_nil @membership.term_years
  end

  test 'cost calculation without ephemeris' do
    @membership.term_months = 12
    @membership.ephemeris = false
    
    expected_cost = SjaaMembers::YEARLY_MEMBERSHIP_RATE
    assert_equal expected_cost, @membership.cost
  end

  test 'cost calculation with ephemeris' do
    @membership.term_months = 12
    @membership.ephemeris = true
    
    expected_cost = SjaaMembers::YEARLY_MEMBERSHIP_RATE + SjaaMembers::EPHEMERIS_FEE
    assert_equal expected_cost, @membership.cost
  end

  test 'cost calculation for multi-year membership' do
    @membership.term_months = 24
    @membership.ephemeris = false
    
    expected_cost = 2 * SjaaMembers::YEARLY_MEMBERSHIP_RATE
    assert_equal expected_cost, @membership.cost
  end

  test 'total includes donation amount' do
    @membership.term_months = 12
    @membership.ephemeris = false
    @membership.donation_amount = 25.0
    
    expected_total = SjaaMembers::YEARLY_MEMBERSHIP_RATE + 25.0
    assert_equal expected_total, @membership.total
  end

  test 'total without donation amount' do
    @membership.term_months = 12
    @membership.ephemeris = false
    @membership.donation_amount = nil
    
    expected_total = SjaaMembers::YEARLY_MEMBERSHIP_RATE
    assert_equal expected_total, @membership.total
  end

  test 'membership can be associated with order' do
    order = Order.create!(price: 75.0, token: 'test_token', paid: false)
    @membership.order = order
    @membership.save!
    
    assert_equal order, @membership.order
  end

  test 'membership can be associated with membership kind' do
    # Assuming MembershipKind model exists
    skip 'MembershipKind model needs to be defined' unless defined?(MembershipKind)
    
    kind = MembershipKind.create!(name: 'Regular')
    @membership.kind = kind
    @membership.save!
    
    assert_equal kind, @membership.kind
  end

  test 'ephemeris flag can be set' do
    @membership.ephemeris = true
    @membership.save!
    
    assert @membership.ephemeris
  end

  test 'membership validation' do
    # Test person is required
    membership_without_person = Membership.new(
      start: Date.current,
      term_months: 12
    )
    assert_not membership_without_person.valid?
    assert_includes membership_without_person.errors[:person], "must exist"
  end

  test 'membership updates end date on multiple saves' do
    @membership.save!
    first_end = @membership.end
    
    # Update start date
    @membership.update!(start: 1.month.from_now.beginning_of_month)
    
    assert_not_equal first_end, @membership.end
    expected_end = (@membership.start + @membership.term_months.months).end_of_month
    assert_in_delta expected_end.to_f, @membership.end.to_f, 1 # Within 1 second tolerance
  end
end