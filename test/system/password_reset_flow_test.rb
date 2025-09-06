require "application_system_test_case"

class PasswordResetFlowTest < ApplicationSystemTestCase
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123", 
      first_name: "Admin",
      last_name: "User"
    )
    
    @person = Person.create!(
      first_name: "John",
      last_name: "Doe",
      signup_completed: true,
      password: "password123"
    )
    
    @contact = Contact.create!(
      email: "john@example.com",
      person: @person,
      primary: true
    )
  end

  test "admin can reset password through full flow" do
    visit new_password_reset_path
    
    fill_in "email", with: @admin.email
    click_on "Send Password Reset"
    
    assert_text "Password reset email has been sent"
    
    # Follow the reset link (simulate clicking from email)
    @admin.reload
    visit edit_password_reset_path(@admin.reset_password_token)
    
    assert_text "Reset Password"
    fill_in "password", with: "newpassword123"
    click_on "Update Password"
    
    assert_text "Your password has been reset!"
    assert_current_path root_path
    
    # Verify login works with new password
    find("a", text: "Logout").click if page.has_content?("Logout")
    
    visit "/login" # assuming login path exists
    fill_in "email", with: @admin.email
    fill_in "password", with: "newpassword123"
    click_on "Login"
    
    # Should be logged in
    assert_current_path root_path
  end

  test "person can reset password through full flow" do
    visit new_password_reset_path
    
    fill_in "email", with: @contact.email
    click_on "Send Password Reset"
    
    assert_text "Password reset email has been sent"
    
    # Follow the reset link
    @person.reload
    visit edit_password_reset_path(@person.reset_password_token)
    
    assert_text "Reset Password"
    fill_in "password", with: "newpassword123"
    click_on "Update Password"
    
    assert_text "Your password has been reset!"
    assert_current_path edit_person_path(id: @person.id)
  end

  test "expired token shows error and redirects" do
    @person.generate_password_reset_token!
    @person.update_column(:reset_password_sent_at, 3.hours.ago)
    
    visit edit_password_reset_path(@person.reset_password_token)
    
    assert_text "Password reset token is invalid or expired"
    assert_current_path new_password_reset_path
  end

  test "invalid token shows error and redirects" do
    visit edit_password_reset_path("invalid_token_123")
    
    assert_text "Password reset token is invalid or expired"
    assert_current_path new_password_reset_path
  end

  test "non-existent email shows error" do
    visit new_password_reset_path
    
    fill_in "email", with: "nonexistent@example.com"
    click_on "Send Password Reset"
    
    assert_text "Email address not found"
  end

  test "password reset form validates password requirements" do
    @person.generate_password_reset_token!
    visit edit_password_reset_path(@person.reset_password_token)
    
    # Try with empty password
    fill_in "password", with: ""
    click_on "Update Password"
    
    assert_text "Password could not be saved"
  end
end