require "application_system_test_case"

class MemberVerificationTest < ApplicationSystemTestCase
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123"
    )

    @read_permission = Permission.find_or_create_by(name: 'read')
    @verify_permission = Permission.find_or_create_by(name: 'verify_members')
    @admin.permissions << @read_permission

    @volunteer = Person.create!(
      first_name: "Volunteer",
      last_name: "User",
      password: "password123"
    )
    @volunteer.permissions << @verify_permission
    Contact.create!(
      email: "volunteer@example.com",
      person: @volunteer,
      primary: true
    )

    @active_member = Person.create!(
      first_name: "Active",
      last_name: "Member",
      password: "password123"
    )

    @active_contact = Contact.create!(
      email: "active@example.com",
      person: @active_member,
      primary: true
    )

    @active_membership = Membership.create!(
      person: @active_member,
      start: 1.month.ago,
      term_months: 12,
      ephemeris: false
    )

    @expired_member = Person.create!(
      first_name: "Expired",
      last_name: "Member",
      password: "password123"
    )

    @expired_contact = Contact.create!(
      email: "expired@example.com",
      person: @expired_member,
      primary: true
    )

    @expired_membership = Membership.create!(
      person: @expired_member,
      start: 2.years.ago,
      term_months: 12,
      ephemeris: false
    )

    @lifetime_member = Person.create!(
      first_name: "Lifetime",
      last_name: "Member",
      password: "password123"
    )

    @lifetime_contact = Contact.create!(
      email: "lifetime@example.com",
      person: @lifetime_member,
      primary: true
    )

    @lifetime_membership = Membership.create!(
      person: @lifetime_member,
      start: 5.years.ago,
      term_months: nil,
      end: nil
    )
  end

  test "admin can access verification form" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    assert_text "Membership Verification"
    assert_text "Enter an email address to verify membership status"
    assert_selector "input[type='email']"
    assert_button "Verify Membership"
  end

  test "volunteer with verify_members permission can access verification form" do
    login_as(@volunteer.primary_contact.email, 'password123')
    visit verify_membership_form_path

    assert_text "Membership Verification"
    assert_selector "input[type='email']"
    assert_button "Verify Membership"
  end

  test "verification shows valid status for active member" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    fill_in "Email Address", with: "active@example.com"
    click_button "Verify Membership"

    assert_text "Valid Member"
    assert_selector ".text-success"

    expected_expiration = @active_membership.end.strftime("%B %Y")
    assert_text "Membership expires: #{expected_expiration}"
    assert_text "Verified on"
  end

  test "verification shows expired status for expired member" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    fill_in "Email Address", with: "expired@example.com"
    click_button "Verify Membership"

    assert_text "Membership Expired"
    assert_selector ".text-danger"

    expected_expiration = @expired_membership.end.strftime("%B %Y")
    assert_text "Expired: #{expected_expiration}"
    assert_text "Verified on"
  end

  test "verification shows lifetime status correctly" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    fill_in "Email Address", with: "lifetime@example.com"
    click_button "Verify Membership"

    assert_text "Valid Member"
    assert_selector ".text-success"
    assert_text "Membership expires: Lifetime"
    assert_text "Verified on"
  end

  test "verification shows not found for non-existent email" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    fill_in "Email Address", with: "nonexistent@example.com"
    click_button "Verify Membership"

    assert_text "No member found with this email address"
    assert_selector ".text-danger"
    assert_text "Verified on"
  end

  test "email field has HTML5 required validation" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    # Verify the email field has the required attribute for HTML5 validation
    assert_selector "input[type='email'][required]"

    # Verify the field is properly labeled
    assert_selector "label", text: "Email Address"
  end

  test "form allows multiple consecutive verifications" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    # First verification
    fill_in "Email Address", with: "active@example.com"
    click_button "Verify Membership"

    assert_text "Valid Member"

    # Second verification - form should still be usable
    fill_in "Email Address", with: "expired@example.com"
    click_button "Verify Membership"

    assert_text "Membership Expired"

    # The form should still be present and functional
    assert_selector "input[type='email']"
    assert_button "Verify Membership"
  end

  test "form handles case-insensitive email lookup" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    fill_in "Email Address", with: "ACTIVE@EXAMPLE.COM"
    click_button "Verify Membership"

    assert_text "Valid Member"
  end

  test "form preserves entered email after verification" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    fill_in "Email Address", with: "active@example.com"
    click_button "Verify Membership"

    # After verification, the email should still be in the field
    assert_field "Email Address", with: "active@example.com"
  end

  test "timestamp updates for each verification" do
    login_as(@admin.email, 'password123')
    visit verify_membership_form_path

    freeze_time do
      fill_in "Email Address", with: "active@example.com"
      click_button "Verify Membership"

      first_timestamp = Time.current.strftime("%B %d, %Y at %I:%M %p")
      assert_text "Verified on #{first_timestamp}"

      # Move time forward and verify again
      travel 1.minute

      fill_in "Email Address", with: "expired@example.com"
      click_button "Verify Membership"

      second_timestamp = Time.current.strftime("%B %d, %Y at %I:%M %p")
      assert_text "Verified on #{second_timestamp}"

      # Should not show the old timestamp
      assert_no_text "Verified on #{first_timestamp}"
    end
  end


end