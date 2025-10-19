require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123"
    )

    @read_permission = Permission.find_or_create_by(name: 'read')
    @verify_permission = Permission.find_or_create_by(name: 'verify_members')
    @admin.permissions << @read_permission

    @person_with_read = Person.create!(
      first_name: "Read",
      last_name: "User",
      password: "password123"
    )
    @person_with_read.permissions << @read_permission
    Contact.create!(
      email: "read@example.com",
      person: @person_with_read,
      primary: true
    )

    @person_with_verify = Person.create!(
      first_name: "Verify",
      last_name: "User",
      password: "password123"
    )
    @person_with_verify.permissions << @verify_permission
    Contact.create!(
      email: "verify@example.com",
      person: @person_with_verify,
      primary: true
    )

    @regular_person = Person.create!(
      first_name: "Regular",
      last_name: "User",
      password: "password123"
    )
    Contact.create!(
      email: "regular@example.com",
      person: @regular_person,
      primary: true
    )

    @member = Person.create!(
      first_name: "Test",
      last_name: "Member",
      password: "password123"
    )

    @contact = Contact.create!(
      email: "member@example.com",
      person: @member,
      primary: true
    )

    @active_membership = Membership.create!(
      person: @member,
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
  end

  # Test access to verification form
  test "verify_form requires authentication" do
    get verify_membership_form_path
    assert_redirected_to login_path
  end

  test "verify_form allows access with read permission" do
    login_as_admin(@admin)
    get verify_membership_form_path
    assert_response :success
    assert_select 'h1', text: 'Membership Verification'
  end

  test "verify_form allows access with verify_members permission" do
    login_as_person(@person_with_verify)
    get verify_membership_form_path
    assert_response :success
    assert_select 'h1', text: 'Membership Verification'
  end

  test "verify_form redirects person without permissions to edit page" do
    login_as_person(@regular_person)
    get verify_membership_form_path
    assert_redirected_to edit_person_path(@regular_person)
  end

  # Test verification functionality
  test "verify with valid active member" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
    assert_select '.text-success'
    assert_select 'small', text: /Verified on/
  end

  test "verify with expired member" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "expired@example.com" }

    assert_response :success
    assert_select '.card-title', text: /Membership Expired/
    assert_select '.text-danger'
    assert_select 'small', text: /Verified on/
  end

  test "verify with non-existent email" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "nonexistent@example.com" }

    assert_response :success
    assert_select '.card-title', text: /No member found/
    assert_select '.text-danger'
    assert_select 'small', text: /Verified on/
  end

  test "verify with blank email shows validation error" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "" }

    assert_response :unprocessable_entity
    assert_select '.alert-danger', text: /Email address is required/
    assert_select 'small', text: /Attempted on/
  end

  test "verify with whitespace-only email shows validation error" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "   " }

    assert_response :unprocessable_entity
    assert_select '.alert-danger', text: /Email address is required/
  end

  test "verify handles case-insensitive email lookup" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "MEMBER@EXAMPLE.COM" }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
  end

  test "verify trims whitespace from email" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "  member@example.com  " }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
  end

  test "verify works with person having verify_members permission" do
    login_as_person(@person_with_verify)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
  end

  test "verify redirects person without permissions to edit page" do
    login_as_person(@regular_person)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_redirected_to edit_person_path(@regular_person)
  end

  test "verify includes timestamp in response" do
    login_as_admin(@admin)

    freeze_time do
      post verify_membership_path, params: { email: "member@example.com" }
      expected_timestamp = Time.current.strftime("%B %d, %Y at %I:%M %p")
      assert_select 'small', text: /Verified on #{Regexp.escape(expected_timestamp)}/
    end
  end

  test "verify shows expiration date for valid membership" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_response :success
    expected_expiration = @active_membership.end.strftime("%B %Y")
    assert_select 'p', text: /Membership expires: #{Regexp.escape(expected_expiration)}/
  end

  test "verify shows expiration date for expired membership" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "expired@example.com" }

    assert_response :success
    expected_expiration = @expired_membership.end.strftime("%B %Y")
    assert_select 'p', text: /Expired: #{Regexp.escape(expected_expiration)}/
  end

  private

  def login_as_admin(admin)
    post sessions_path, params: { email: admin.email, password: 'password123' }
  end

  def login_as_person(person)
    post sessions_path, params: { email: person.primary_contact.email, password: 'password123' }
  end
end