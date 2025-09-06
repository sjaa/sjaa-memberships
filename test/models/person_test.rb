require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @referral = Referral.create!(name: 'internet', description: 'Web search')
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      signup_completed: true,
      referral: @referral
    )
    @contact = Contact.create!(
      email: 'john@example.com',
      person: @person,
      primary: true
    )
  end

  test 'valid person with required attributes' do
    assert @person.valid?
    assert_equal 'John Doe', @person.name
  end

  test 'person can have multiple contacts' do
    secondary_contact = Contact.create!(
      email: 'john.work@example.com',
      person: @person,
      primary: false
    )
    
    assert_equal 2, @person.contacts.count
    assert_equal @contact, @person.primary_contact
  end

  test 'find_by_email returns person for primary contact email' do
    found_person = Person.find_by_email(@contact.email)
    assert_equal @person, found_person
  end

  test 'find_by_email returns person for any contact email' do
    secondary_contact = Contact.create!(
      email: 'john.alt@example.com',
      person: @person,
      primary: false
    )
    
    found_person = Person.find_by_email(secondary_contact.email)
    assert_equal @person, found_person
  end

  test 'find_by_email returns nil for non-existent email' do
    found_person = Person.find_by_email('nonexistent@example.com')
    assert_nil found_person
  end

  test 'incomplete signup person has signup_completed false' do
    incomplete_person = Person.create!(
      first_name: 'Jane',
      last_name: 'Smith',
      signup_completed: false
    )
    
    assert_not incomplete_person.signup_completed
  end

  test 'person status reflects membership status' do
    # Person with no membership
    assert_equal 'Expired', @person.status
    assert_not @person.is_active?
    
    # Person with active membership
    Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    @person.reload
    assert_equal 'Active', @person.status
    assert @person.is_active?
  end

  test 'lifetime member status' do
    Membership.create!(
      person: @person,
      start: Date.current,
      term_months: nil # lifetime membership
    )
    
    @person.reload
    assert @person.is_lifetime_member
    assert @person.is_active?
    assert_equal 'Active', @person.status
  end

  test 'next_membership_start_date for new member' do
    # No existing memberships
    assert_equal Date.today, @person.next_membership_start_date
  end

  test 'next_membership_start_date for active member' do
    membership = Membership.create!(
      person: @person,
      start: Date.current.beginning_of_month,
      term_months: 12
    )
    
    @person.reload
    expected_date = membership.end.beginning_of_month
    assert_equal expected_date, @person.next_membership_start_date
  end

  test 'next_membership_start_date for lifetime member returns nil' do
    Membership.create!(
      person: @person,
      start: Date.current,
      term_months: nil # lifetime membership
    )
    
    @person.reload
    assert_nil @person.next_membership_start_date
  end

  test 'latest_membership returns most recent membership' do
    old_membership = Membership.create!(
      person: @person,
      start: 1.year.ago,
      term_months: 12
    )
    
    recent_membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    assert_equal recent_membership, @person.latest_membership
  end

  test 'first_membership returns earliest membership' do
    recent_membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    first_membership = Membership.create!(
      person: @person,
      start: 2.years.ago,
      term_months: 12
    )
    
    assert_equal first_membership, @person.first_membership
  end

  test 'active_membership returns current active membership' do
    # Expired membership
    Membership.create!(
      person: @person,
      start: 2.years.ago,
      term_months: 12
    )
    
    # Active membership
    active_membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    assert_equal active_membership, @person.active_membership.first
  end

  test 'password reset functionality through PasswordResettable concern' do
    assert_respond_to @person, :generate_password_reset_token!
    assert_respond_to @person, :password_reset_token_valid?
    assert_respond_to @person, :reset_password!
    
    @person.generate_password_reset_token!
    assert_not_nil @person.reset_password_token
    assert @person.password_reset_token_valid?
    
    @person.reset_password!('newpassword')
    assert @person.authenticate('newpassword')
    assert_nil @person.reset_password_token
  end

  test 'person has no permissions by default' do
    assert_not @person.has_permission?('read')
    assert_not @person.has_permission?('write')
    assert_not @person.has_permission?('permit')
  end

  test 'person can have api keys' do
    api_key = ApiKey.create!(bearer: @person, token: 'test_token_123')
    assert_includes @person.api_keys, api_key
  end

  test 'person can have memberships, donations, equipment, and contacts' do
    membership = Membership.create!(person: @person, start: Date.current, term_months: 12)
    donation = Donation.create!(person: @person, name: 'Test Donation')
    
    assert_includes @person.memberships, membership
    assert_includes @person.donations, donation
    assert_includes @person.contacts, @contact
  end
end