require "application_system_test_case"

class AdminRenewalTest < ApplicationSystemTestCase
  setup do
    setup_test_constants

    # Create an admin with write permissions
    @read_permission = Permission.create!(name: 'read')
    @write_permission = Permission.create!(name: 'write')
    @admin = Admin.create!(
      email: 'admin@sjaa.org',
      password: 'password123',
      permissions: [@read_permission, @write_permission]
    )

    # Create an admin with only read permissions
    @read_only_admin = Admin.create!(
      email: 'readonly@sjaa.org',
      password: 'password123',
      permissions: [@read_permission]
    )

    # Create a person
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123'
    )

    @contact = Contact.create!(
      email: 'john@example.com',
      person: @person,
      primary: true
    )

    # Create membership kinds
    @standard_kind = MembershipKind.create!(name: "Standard")
    @student_kind = MembershipKind.create!(name: "Student")
  end

  test "admin renew button is visible to admin with write permission" do
    login_as(@admin.email, 'password123')
    visit person_path(@person)

    assert_text "John Doe"
    assert_button "Admin Renew"
  end

  test "admin renew button is not visible to admin with only read permission" do
    login_as(@read_only_admin.email, 'password123')
    visit person_path(@person)

    assert_text "John Doe"
    assert_no_button "Admin Renew"
  end

  test "admin can create membership via admin renew modal" do
    login_as(@admin.email, 'password123')
    visit person_path(@person)

    # Click the Admin Renew button to open modal
    click_button "Admin Renew"

    # Wait for modal to appear
    assert_selector "#adminRenewModal", visible: true, wait: 2

    # Verify modal title
    within("#adminRenewModal") do
      assert_text "Admin Renew Membership for John Doe"

      # Fill in the form within the form card
      within("#admin_renew_membership") do
        # Start date is readonly, so we don't need to fill it
        fill_in "membership_term_months", with: "12"
        # Ephemeris is now a combobox, select "Yes"
        select "Yes", from: "membership_ephemeris"
        fill_in "membership_donation_amount", with: "25.00"
        select @standard_kind.name, from: "membership_kind_id"
      end

      # Submit the form (button is in modal footer, outside the card)
      click_button "Create Membership"
    end

    # Verify success message
    assert_text "Membership was successfully created for John Doe"

    # Verify the membership was created
    @person.reload
    latest_membership = @person.memberships.order(:created_at).last
    assert_not_nil latest_membership
    assert_equal Date.today, latest_membership.start.to_date
    assert_equal 12, latest_membership.term_months
    assert latest_membership.ephemeris
    assert_equal 25.00, latest_membership.donation_amount
    assert_equal @standard_kind.id, latest_membership.kind_id
  end

  test "admin renew modal pre-fills start date with next_membership_start_date" do
    # Create an existing membership
    Membership.create!(
      person: @person,
      start: 6.months.ago,
      term_months: 12,
      ephemeris: false
    )

    expected_start_date = @person.next_membership_start_date

    login_as(@admin.email, 'password123')
    visit person_path(@person)

    # Click the Admin Renew button
    click_button "Admin Renew"

    # Verify the start date is pre-filled
    within("#adminRenewModal") do
      start_field = find_field("membership_start")
      assert_equal expected_start_date.strftime('%Y-%m-%d'), start_field.value
    end
  end

  test "admin renew modal pre-fills term with DEFAULT_MEMBERSHIP_TERM" do
    login_as(@admin.email, 'password123')
    visit person_path(@person)

    # Click the Admin Renew button
    click_button "Admin Renew"

    # Verify the term months is pre-filled with default value
    within("#adminRenewModal") do
      term_field = find_field("membership_term_months")
      assert_equal SjaaMembers::DEFAULT_MEMBERSHIP_TERM.to_s, term_field.value
    end
  end

  test "admin can add notes and author is set automatically" do
    login_as(@admin.email, 'password123')
    visit person_path(@person)

    # Click the Admin Renew button
    click_button "Admin Renew"

    within("#adminRenewModal") do
      within("#admin_renew_membership") do
        fill_in "membership_notes", with: "Comp membership for volunteer work"
      end

      click_button "Create Membership"
    end

    # Wait for success message
    assert_text "Membership was successfully created"

    # Verify the note was saved and author was set
    @person.reload
    latest_membership = @person.memberships.order(:created_at).last
    assert_not_nil latest_membership, "Membership should have been created"
    assert_equal "Comp membership for volunteer work", latest_membership.notes
    assert_equal @admin.email, latest_membership.author
  end

  test "admin can close modal without creating membership" do
    login_as(@admin.email, 'password123')
    visit person_path(@person)

    initial_membership_count = @person.memberships.count

    # Click the Admin Renew button
    click_button "Admin Renew"

    # Wait for modal to appear
    assert_selector "#adminRenewModal", visible: true, wait: 2

    # Close the modal using the Cancel button
    within("#adminRenewModal") do
      click_button "Cancel"
    end

    # Wait for modal to be hidden (not visible, but still in DOM)
    sleep 0.5  # Give Bootstrap modal time to animate

    # Verify no membership was created
    @person.reload
    assert_equal initial_membership_count, @person.memberships.count
  end

  test "admin renew creates membership visible in membership history" do
    login_as(@admin.email, 'password123')
    visit person_path(@person)

    # Click the Admin Renew button
    click_button "Admin Renew"

    within("#adminRenewModal") do
      within("#admin_renew_membership") do
        fill_in "membership_term_months", with: "24"
        select @student_kind.name, from: "membership_kind_id"
        fill_in "membership_notes", with: "Test renewal"
      end

      click_button "Create Membership"
    end

    # Wait for success message
    assert_text "Membership was successfully created"

    # Verify the membership appears in the membership history table
    within(".card", text: "Membership History") do
      assert_text "24 months"
      assert_text "Test renewal"
      assert_text "Active"
    end

    # Verify the kind was saved (even though it's not displayed in the table)
    @person.reload
    latest_membership = @person.memberships.order(:created_at).last
    assert_equal @student_kind.id, latest_membership.kind_id
  end

  private

  def setup_test_constants
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
    end
    unless defined?(SjaaMembers::DEFAULT_MEMBERSHIP_TERM)
      stub_const('SjaaMembers::DEFAULT_MEMBERSHIP_TERM', 12)
    end
  end

  def stub_const(const_name, value)
    const_parts = const_name.split('::')
    if const_parts.length == 2
      mod = const_parts[0].constantize rescue nil
      if mod.nil?
        Object.const_set(const_parts[0], Module.new)
        mod = const_parts[0].constantize
      end
      mod.const_set(const_parts[1], value) unless mod.const_defined?(const_parts[1])
    end
  rescue
    Object.const_set(const_name.gsub('::', '_'), value) unless Object.const_defined?(const_name.gsub('::', '_'))
  end
end
