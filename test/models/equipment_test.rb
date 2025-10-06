require 'test_helper'

class EquipmentTest < ActiveSupport::TestCase
  setup do
    @instrument = Instrument.create!(kind: 'telescope', model: 'Celestron NexStar 8SE')
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      signup_completed: true,
      referral: Referral.create!(name: 'internet', description: 'Web search')
    )
    @equipment = Equipment.create!(
      instrument: @instrument,
      person: @person,
      note: 'Great telescope for viewing planets'
    )
  end

  test 'valid equipment with required attributes' do
    assert @equipment.valid?
    assert_equal 'telescope', @equipment.instrument.kind
    assert_equal 'CELESTRON NEXSTAR 8SE', @equipment.instrument.model
  end

  test 'donation_summary returns nil when no donation items' do
    assert_nil @equipment.donation_summary
  end

  test 'donation_summary with single donation item' do
    donation = Donation.create!(person: @person)
    donation_item = DonationItem.create!(
      donation: donation,
      equipment: @equipment,
      value: 100.50
    )

    result = @equipment.donation_summary
    assert_equal "Donated ($100.5)", result
  end

  test 'donation_summary with multiple donation items' do
    donation1 = Donation.create!(person: @person)
    donation2 = Donation.create!(person: @person)

    DonationItem.create!(
      donation: donation1,
      equipment: @equipment,
      value: 100.0
    )
    DonationItem.create!(
      donation: donation2,
      equipment: @equipment,
      value: 50.0
    )

    result = @equipment.donation_summary
    assert_equal "2 donations ($150.0)", result
  end

  test 'donation_summary handles nil values in donation items' do
    donation = Donation.create!(person: @person)
    DonationItem.create!(
      donation: donation,
      equipment: @equipment,
      value: nil
    )

    result = @equipment.donation_summary
    assert_equal "Donated ($0)", result
  end

  test 'donation_summary handles mixed nil and valid values' do
    donation1 = Donation.create!(person: @person)
    donation2 = Donation.create!(person: @person)
    donation3 = Donation.create!(person: @person)

    DonationItem.create!(
      donation: donation1,
      equipment: @equipment,
      value: 100.0
    )
    DonationItem.create!(
      donation: donation2,
      equipment: @equipment,
      value: nil
    )
    DonationItem.create!(
      donation: donation3,
      equipment: @equipment,
      value: 25.0
    )

    result = @equipment.donation_summary
    assert_equal "3 donations ($125.0)", result
  end

  test 'donation_summary handles zero value donations' do
    donation = Donation.create!(person: @person)
    DonationItem.create!(
      donation: donation,
      equipment: @equipment,
      value: 0
    )

    result = @equipment.donation_summary
    assert_equal "Donated ($0.0)", result
  end

  test 'equipment can exist without person' do
    equipment = Equipment.create!(
      instrument: @instrument,
      note: 'Club equipment'
    )

    assert equipment.valid?
    assert_nil equipment.person
  end

  test 'equipment can exist without role' do
    equipment = Equipment.create!(
      instrument: @instrument,
      person: @person,
      note: 'Personal equipment'
    )

    assert equipment.valid?
    assert_nil equipment.role
  end

  test 'equipment associations work correctly' do
    # Test that the associations are properly set up
    donation = Donation.create!(person: @person)
    donation_item = DonationItem.create!(
      donation: donation,
      equipment: @equipment,
      value: 100.0
    )

    # Reload to ensure associations are loaded
    @equipment.reload

    assert_equal 1, @equipment.donation_items.count
    assert_equal 1, @equipment.donations.count
    assert_equal donation, @equipment.donations.first
    assert_equal donation_item, @equipment.donation_items.first
  end
end