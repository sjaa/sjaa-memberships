require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  setup do
    @person = Person.create!(
      first_name: 'Jane',
      last_name: 'Donor',
      password: 'password123'
    )
    @contact = Contact.create!(
      email: 'jane@example.com',
      person: @person,
      primary: true
    )
    @donation = Donation.create!(
      person: @person,
      name: 'Test Donation 2025'
    )
    @instrument = Instrument.create!(kind: 'telescope', model: 'Celestron NexStar 8SE')
  end

  # Basic functionality tests
  test 'valid donation with required attributes' do
    assert @donation.valid?
    assert_equal @person, @donation.person
  end

  test 'donation can exist without person' do
    donation = Donation.create!(name: 'Anonymous Donation')
    assert donation.valid?
    assert_nil donation.person
  end

  test 'donation value is sum of all items' do
    @donation.items.create!(value: 100.0, cash: true)
    @donation.items.create!(value: 250.0, cash: false)

    assert_equal 350.0, @donation.value
  end

  test 'donation value is zero when no items' do
    assert_equal 0, @donation.value
  end

  # Cash item tests
  test 'cash= creates new cash item when id is not present' do
    @donation.cash = { value: '500.0', cash: 'true' }

    assert_equal 1, @donation.items.count
    cash_item = @donation.items.first
    assert_equal 500.0, cash_item.value
    assert cash_item.cash
    assert_nil cash_item.equipment_id
  end

  test 'cash= updates existing cash item when id is present' do
    existing_item = @donation.items.create!(value: 100.0, cash: true)

    @donation.cash = { id: existing_item.id.to_s, value: '250.0', cash: 'true' }

    existing_item.reload
    assert_equal 250.0, existing_item.value
    assert_equal 1, @donation.items.count
  end

  test 'cash= skips creation when value is zero and no id' do
    @donation.cash = { value: '0', cash: 'true' }

    assert_equal 0, @donation.items.count
  end

  test 'cash= handles blank value strings' do
    @donation.cash = { value: '', cash: 'true' }

    assert_equal 0, @donation.items.count
  end

  test 'cash= preserves existing cash item in items collection' do
    existing_item = @donation.items.create!(value: 100.0, cash: true)

    @donation.cash = { id: existing_item.id.to_s, value: '250.0', cash: 'true' }

    assert_equal 1, @donation.items.count
    assert_includes @donation.items, existing_item
  end

  # Items attributes tests
  test 'items_attributes= creates new equipment item' do
    @donation.items_attributes = [{
      value: '500.0',
      equipment_attributes: {
        note: 'Great condition',
        instrument_attributes: { kind: 'telescope', model: @instrument.model }
      }
    }]

    assert_equal 1, @donation.items.count
    item = @donation.items.first
    assert_equal 500.0, item.value
    assert_not_nil item.equipment
    assert_equal 'Great condition', item.equipment.note
  end

  test 'items_attributes= updates existing equipment item' do
    equipment = Equipment.create!(instrument: @instrument, note: 'Old note')
    existing_item = @donation.items.create!(value: 100.0, equipment: equipment)

    @donation.items_attributes = [{
      id: existing_item.id.to_s,
      value: '250.0',
      equipment_attributes: {
        id: equipment.id.to_s,
        note: 'Updated note',
        instrument_attributes: { kind: @instrument.kind, model: @instrument.model }
      }
    }]

    existing_item.reload
    assert_equal 250.0, existing_item.value
    assert_equal 'Updated note', existing_item.equipment.note
  end

  test 'items_attributes= preserves existing cash items' do
    cash_item = @donation.items.create!(value: 400.0, cash: true)

    @donation.items_attributes = [{
      value: '500.0',
      equipment_attributes: {
        note: 'Equipment note',
        instrument_attributes: { kind: 'telescope', model: @instrument.model }
      }
    }]
    @donation.save!

    @donation.reload
    assert_equal 2, @donation.items.count
    assert_includes @donation.items, cash_item
    # Check that at least one item has equipment (by equipment_id presence)
    assert @donation.items.any? { |item| item.equipment_id.present? }, "Expected at least one item to have equipment"
  end

  test 'items_attributes= removes equipment items not in the list' do
    equipment1 = Equipment.create!(instrument: @instrument)
    equipment2 = Equipment.create!(instrument: @instrument)
    item1 = @donation.items.create!(value: 100.0, equipment: equipment1)
    item2 = @donation.items.create!(value: 200.0, equipment: equipment2)

    # Only include item1 in the update
    @donation.items_attributes = [{
      id: item1.id.to_s,
      value: '150.0',
      equipment_attributes: {
        id: equipment1.id.to_s,
        note: 'Updated',
        instrument_attributes: { kind: @instrument.kind, model: @instrument.model }
      }
    }]

    @donation.reload
    assert_equal 1, @donation.items.count
    assert_includes @donation.items, item1
    assert_not_includes @donation.items, item2
  end

  test 'items_attributes= does not remove cash items when removing equipment items' do
    cash_item = @donation.items.create!(value: 400.0, cash: true)
    equipment = Equipment.create!(instrument: @instrument)
    equipment_item = @donation.items.create!(value: 500.0, equipment: equipment)

    # Remove all equipment items by passing empty array
    @donation.items_attributes = []

    @donation.reload
    assert_equal 1, @donation.items.count
    assert_includes @donation.items, cash_item
    assert_not_includes @donation.items, equipment_item
  end

  test 'items_attributes= skips items with blank equipment data and blank value' do
    @donation.items_attributes = [{
      id: '',
      value: '',
      equipment_attributes: {
        id: '',
        note: '',
        instrument_attributes: { kind: '', model: '' }
      }
    }]

    assert_equal 0, @donation.items.count
  end

  test 'items_attributes= skips items with partial equipment data (kind only)' do
    @donation.items_attributes = [{
      value: '',
      equipment_attributes: {
        note: '',
        instrument_attributes: { kind: 'telescope', model: '' }
      }
    }]

    assert_equal 0, @donation.items.count
  end

  test 'items_attributes= skips items with partial equipment data (model only)' do
    @donation.items_attributes = [{
      value: '',
      equipment_attributes: {
        note: '',
        instrument_attributes: { kind: '', model: 'NexStar' }
      }
    }]

    assert_equal 0, @donation.items.count
  end

  # Integration tests - combining cash and equipment items
  test 'can update cash and equipment items together' do
    cash_item = @donation.items.create!(value: 300.0, cash: true)
    equipment = Equipment.create!(instrument: @instrument)
    equipment_item = @donation.items.create!(value: 500.0, equipment: equipment)

    # Update both via params
    params = {
      cash: { id: cash_item.id.to_s, value: '400.0', cash: 'true' },
      items_attributes: [{
        id: equipment_item.id.to_s,
        value: '600.0',
        equipment_attributes: {
          id: equipment.id.to_s,
          note: 'Updated equipment',
          instrument_attributes: { kind: @instrument.kind, model: @instrument.model }
        }
      }]
    }

    @donation.cash = params[:cash]
    @donation.items_attributes = params[:items_attributes]
    @donation.save!

    @donation.reload
    assert_equal 2, @donation.items.count
    cash_item.reload
    equipment_item.reload
    assert_equal 400.0, cash_item.value
    assert_equal 600.0, equipment_item.value
  end

  test 'cash item is preserved when items_attributes removes equipment items' do
    cash_item = @donation.items.create!(value: 400.0, cash: true)
    equipment = Equipment.create!(instrument: @instrument)
    equipment_item = @donation.items.create!(value: 500.0, equipment: equipment)

    # Remove equipment item via empty items_attributes
    @donation.items_attributes = []
    @donation.save!

    @donation.reload
    assert_equal 1, @donation.items.count
    assert_includes @donation.items, cash_item
  end

  test 'cash item is preserved when adding new equipment items' do
    cash_item = @donation.items.create!(value: 400.0, cash: true)
    @donation.reload  # Ensure cash_item is in the loaded association

    # Add new equipment item
    @donation.items_attributes = [{
      value: '500.0',
      equipment_attributes: {
        note: 'New equipment',
        instrument_attributes: { kind: 'telescope', model: @instrument.model }
      }
    }]
    @donation.save!

    @donation.reload
    assert_equal 2, @donation.items.count
    assert_includes @donation.items, cash_item
    # Check that at least one item has equipment (by equipment_id presence)
    assert @donation.items.any? { |item| item.equipment_id.present? }, "Expected at least one item to have equipment"
  end

  # Person attributes tests
  test 'person_attributes= finds existing person by email' do
    existing_person = Person.create!(
      first_name: 'John',
      last_name: 'Smith',
      password: 'password123'
    )
    Contact.create!(email: 'john@example.com', person: existing_person, primary: true)

    new_donation = Donation.new(name: 'Test')
    new_donation.person_attributes = {
      first_name: 'Different',
      last_name: 'Name',
      email: 'john@example.com'
    }

    assert_equal existing_person, new_donation.person
  end

  test 'person_attributes= creates new person when email not found' do
    new_donation = Donation.new(name: 'Test')
    new_donation.person_attributes = {
      first_name: 'New',
      last_name: 'Person',
      email: 'newperson@example.com'
    }

    assert_not_nil new_donation.person
    assert_equal 'New', new_donation.person.first_name
    assert_equal 'Person', new_donation.person.last_name
    assert_equal 'newperson@example.com', new_donation.person.primary_contact.email
  end

  test 'person_attributes= skips when email is blank' do
    new_donation = Donation.new(name: 'Test', person: @person)
    new_donation.person_attributes = {
      first_name: 'Should',
      last_name: 'Ignore',
      email: ''
    }

    # Person should remain unchanged
    assert_equal @person, new_donation.person
  end

  # Effective dates tests
  test 'effective_dates returns unique dates from donation phases' do
    item1 = @donation.items.create!(value: 100.0)
    item2 = @donation.items.create!(value: 200.0)

    date1 = Date.new(2025, 1, 15)
    date2 = Date.new(2025, 2, 20)

    DonationPhase.create!(donation_item: item1, date: date1, person: @person)
    DonationPhase.create!(donation_item: item2, date: date2, person: @person)
    DonationPhase.create!(donation_item: item2, date: date1, person: @person) # Duplicate date

    dates = @donation.effective_dates
    assert_equal 2, dates.length
    assert_includes dates, date1
    assert_includes dates, date2
  end

  test 'effective_dates excludes nil dates' do
    item = @donation.items.create!(value: 100.0)

    DonationPhase.create!(donation_item: item, date: Date.new(2025, 1, 15), person: @person)
    DonationPhase.create!(donation_item: item, date: nil, person: @person)

    dates = @donation.effective_dates
    assert_equal 1, dates.length
    assert_equal Date.new(2025, 1, 15), dates.first
  end

  test 'effective_dates returns empty array when no phases' do
    assert_equal [], @donation.effective_dates
  end
end
