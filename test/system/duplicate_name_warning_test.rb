require "application_system_test_case"

class DuplicateNameWarningTest < ApplicationSystemTestCase
  setup do
    # Create an admin to bypass the setup wizard
    Admin.create!(email: 'test@sjaa.net', password: 'password123') if Admin.count == 0

    # Create existing people with similar names
    @john_smith = Person.create!(
      first_name: 'John',
      last_name: 'Smith',
      password: 'password123'
    )
    Contact.create!(
      email: 'john.smith@example.com',
      person: @john_smith,
      primary: true
    )

    @jon_smith = Person.create!(
      first_name: 'Jon',
      last_name: 'Smith',
      password: 'password123'
    )
    Contact.create!(
      email: 'jon.smith@example.com',
      person: @jon_smith,
      primary: true
    )
  end

  test "new member signup shows warning for similar names" do
    visit signup_path

    # Fill out signup form with a name similar to existing person
    fill_in "first_name", with: "John"
    fill_in "last_name", with: "Smyth"
    fill_in "email", with: "john.smyth@example.com"
    fill_in "password", with: "newpassword123"
    click_on "Sign Up"

    # Should redirect back to signup page with warning
    assert_current_path signup_path

    # Should display warning message about similar names
    assert_text "We found existing accounts with similar names"
    assert_text "John Smith"

    # Should suggest login or password reset
    assert_text "logging in with a different email"
    assert_text "resetting your password"

    # Should repopulate the form fields (except password)
    assert_equal "John", find_field("first_name").value
    assert_equal "Smyth", find_field("last_name").value
    assert_equal "john.smyth@example.com", find_field("email").value
  end

  test "new member can proceed after seeing duplicate name warning" do
    visit signup_path

    # Fill out signup form with a name similar to existing person
    fill_in "first_name", with: "John"
    fill_in "last_name", with: "Smyth"
    fill_in "email", with: "john.smyth@example.com"
    fill_in "password", with: "newpassword123"
    click_on "Sign Up"

    # Should show warning and redirect back to signup
    assert_text "We found existing accounts with similar names"
    assert_current_path signup_path

    # Form should be repopulated
    assert_equal "John", find_field("first_name").value
    assert_equal "Smyth", find_field("last_name").value
    assert_equal "john.smyth@example.com", find_field("email").value

    # User can proceed by submitting again (acknowledge_warning is now set in hidden field)
    fill_in "password", with: "newpassword123"  # Password not repopulated for security
    click_on "Sign Up"

    # This time it should proceed (warning acknowledged)
    assert_current_path login_path
    assert_text "We sent you an email to complete the sign up process"
  end

  test "new member signup proceeds normally for dissimilar names" do
    visit signup_path

    # Fill out signup form with a completely different name
    fill_in "first_name", with: "Alice"
    fill_in "last_name", with: "Johnson"
    fill_in "email", with: "alice.johnson@example.com"
    fill_in "password", with: "password123"
    click_on "Sign Up"

    # Should proceed to login page without warning
    assert_current_path login_path
    assert_text "We sent you an email to complete the sign up process"

    # Should NOT show duplicate name warning
    assert_no_text "similar names"
  end

  test "duplicate name warning shows multiple similar people" do
    # Create another similar person
    johnny_smith = Person.create!(
      first_name: 'Johnny',
      last_name: 'Smith',
      password: 'password123'
    )
    Contact.create!(
      email: 'johnny.smith@example.com',
      person: johnny_smith,
      primary: true
    )

    visit signup_path

    # Try to sign up with a very similar name
    fill_in "first_name", with: "John"
    fill_in "last_name", with: "Smith"
    fill_in "email", with: "new.john.smith@example.com"
    fill_in "password", with: "password123"
    click_on "Sign Up"

    # Should show warning with multiple similar names
    assert_text "We found existing accounts with similar names"

    # Should mention at least one of the similar people (up to 3 shown)
    assert_text "John Smith"
  end

  test "duplicate name warning includes similarity percentage" do
    visit signup_path

    # Fill out signup form with a very similar name
    fill_in "first_name", with: "Jon"
    fill_in "last_name", with: "Smith"
    fill_in "email", with: "different.email@example.com"
    fill_in "password", with: "password123"
    click_on "Sign Up"

    # Should show warning with percentage match
    assert_text "We found existing accounts with similar names"
    assert_text "% match"  # Should show percentage in the warning
  end

  test "exact duplicate email still blocks signup" do
    visit signup_path

    # Try to sign up with existing email
    fill_in "first_name", with: "Different"
    fill_in "last_name", with: "Person"
    fill_in "email", with: "john.smith@example.com"  # Existing email
    fill_in "password", with: "password123"
    click_on "Sign Up"

    # Should redirect to login with error (not just warning)
    assert_current_path login_path
    assert_text "already registered"
    assert_text "Please log in or reset your password"
  end

  test "warning message is styled as warning not error" do
    visit signup_path

    # Fill out signup form with similar name
    fill_in "first_name", with: "John"
    fill_in "last_name", with: "Smyth"
    fill_in "email", with: "john.smyth@example.com"
    fill_in "password", with: "password123"
    click_on "Sign Up"

    # Should have warning alert (not danger/error alert)
    assert_selector '.alert-warning', text: 'similar names'
  end

  test "signup with blank names does not crash" do
    # Edge case: ensure system handles blank names gracefully
    blank_person = Person.create!(
      first_name: '',
      last_name: '',
      password: 'password123'
    )
    Contact.create!(
      email: 'blank@example.com',
      person: blank_person,
      primary: true
    )

    visit signup_path

    # Try to sign up normally
    fill_in "first_name", with: "Regular"
    fill_in "last_name", with: "User"
    fill_in "email", with: "regular@example.com"
    fill_in "password", with: "password123"

    # Should not crash
    assert_nothing_raised do
      click_on "Sign Up"
    end

    # Should proceed normally (no crash, no false positive match)
    assert_current_path login_path
  end
end
