require "application_system_test_case"

class LoginRedirectTest < ApplicationSystemTestCase
  setup do
    # Create an admin to bypass the setup wizard
    Admin.create!(email: 'admin@sjaa.net', password: 'password123') if Admin.count == 0

    # Create a test person
    @person = Person.create!(
      first_name: "Test",
      last_name: "User",
      password: "password123"
    )
    Contact.create!(
      email: "testuser@example.com",
      person: @person,
      primary: true
    )

    # Create an active membership so they don't get redirected to renewal
    Membership.create!(
      person: @person,
      start: Date.current - 1.month,
      term_months: 12
    )
  end

  test "redirects to original destination after login when accessing protected page" do
    # Try to access a protected page without being logged in
    visit edit_person_path(@person)

    # Should be redirected to login page
    assert_current_path login_path
    assert_text "Please log in to continue"

    # Log in
    fill_in 'email', with: 'testuser@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Login'

    # Should be redirected to the original destination (edit_person_path)
    assert_current_path edit_person_path(@person)
    assert_text "Successful login!"
  end

  test "redirects to original destination with query parameters preserved" do
    # Try to access membership renewal page with an ID
    visit membership_renewal_path(@person)

    # Should be redirected to login page
    assert_current_path login_path

    # Log in
    fill_in 'email', with: 'testuser@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Login'

    # Should be redirected to the membership renewal page
    assert_current_path membership_renewal_path(@person)
  end

  test "uses default redirect when no return_to path is saved" do
    # Visit login page directly (no return_to saved)
    visit login_path

    # Log in
    fill_in 'email', with: 'testuser@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Login'

    # Should use default redirect (person_path for active members)
    assert_current_path person_path(@person)
    assert_text "Successful login!"
  end

  test "admin redirects to root path by default which then redirects to people index" do
    read_permission = Permission.create!(name: 'read')
    admin = Admin.create!(
      email: 'testadmin@sjaa.net',
      password: 'adminpass',
      permissions: [read_permission]
    )

    # Visit login page directly
    visit login_path

    # Log in as admin
    fill_in 'email', with: 'testadmin@sjaa.net'
    fill_in 'password', with: 'adminpass'
    click_button 'Login'

    # Should redirect to root path, which then redirects admins to people index
    assert_current_path people_path
    assert_text "Successful login!"
  end

  test "admin redirects to original destination when accessing protected page" do
    read_permission = Permission.create!(name: 'read')
    write_permission = Permission.create!(name: 'write')
    admin = Admin.create!(
      email: 'testadmin@sjaa.net',
      password: 'adminpass',
      permissions: [read_permission, write_permission]
    )

    # Try to access people index without being logged in
    visit people_path

    # Should be redirected to login page
    assert_current_path login_path

    # Log in as admin
    fill_in 'email', with: 'testadmin@sjaa.net'
    fill_in 'password', with: 'adminpass'
    click_button 'Login'

    # Should be redirected back to people index
    assert_current_path people_path
    assert_text "Successful login!"
  end

  test "inactive member redirects to renewal page but preserves original destination concept" do
    # Create an inactive member (expired membership)
    inactive_person = Person.create!(
      first_name: "Inactive",
      last_name: "Member",
      password: "password123"
    )
    Contact.create!(
      email: "inactive@example.com",
      person: inactive_person,
      primary: true
    )

    # Create expired membership
    Membership.create!(
      person: inactive_person,
      start: Date.current - 13.months,
      term_months: 12
    )

    # Visit login page directly
    visit login_path

    # Log in as inactive member
    fill_in 'email', with: 'inactive@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Login'

    # Inactive members always go to renewal page (this is the existing behavior)
    assert_current_path membership_renewal_path(inactive_person)
    assert_text "time to renew your membership"
  end
end
