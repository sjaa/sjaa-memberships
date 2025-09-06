require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net", 
      password: "password123"
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

  test "should get new password reset page" do
    get new_password_reset_path
    assert_response :success
    assert_select "form"
  end

  test "should create password reset for existing admin" do
    assert_emails 1 do
      post password_resets_path, params: { email: @admin.email }
    end
    
    @admin.reload
    assert_not_nil @admin.reset_password_token
    assert_not_nil @admin.reset_password_sent_at
    assert_redirected_to login_path
    assert_equal "Password reset email has been sent.", flash[:notice]
  end

  test "should create password reset for existing person" do
    assert_emails 1 do
      post password_resets_path, params: { email: @contact.email }
    end
    
    @person.reload
    assert_not_nil @person.reset_password_token
    assert_not_nil @person.reset_password_sent_at
    assert_redirected_to login_path
    assert_equal "Password reset email has been sent.", flash[:notice]
  end

  test "should create new person for signup with password reset" do
    new_email = "newuser@example.com"
    
    assert_difference "Person.count", 1 do
      assert_difference "Contact.count", 1 do
        assert_emails 1 do
          post password_resets_path, params: {
            email: new_email,
            signup: "true",
            first_name: "Jane",
            last_name: "Smith"
          }
        end
      end
    end
    
    person = Person.last
    assert_equal "Jane", person.first_name
    assert_equal "Smith", person.last_name
    assert_equal false, person.signup_completed
    assert_not_nil person.reset_password_token
    assert_redirected_to post_signup_path(person_id: person.id)
  end

  test "should reject signup for existing email" do
    post password_resets_path, params: {
      email: @contact.email,
      signup: "true",
      first_name: "Jane",
      last_name: "Smith"
    }
    
    assert_redirected_to login_path
    assert_equal "The email #{@contact.email} is already registered.  Please log in or reset your password.", flash[:alert]
  end

  test "should show error for non-existent email without signup" do
    post password_resets_path, params: { email: "nonexistent@example.com" }
    
    assert_redirected_to login_path
    assert_equal "Email address not found.", flash[:alert]
  end

  test "should show password reset edit form with valid token" do
    @person.generate_password_reset_token!
    
    get edit_password_reset_path(@person.reset_password_token)
    assert_response :success
    assert_select "form"
    assert_select "input[type=password]"
  end

  test "should redirect for invalid reset token" do
    get edit_password_reset_path("invalid_token")
    
    assert_redirected_to new_password_reset_path
    assert_equal "Password reset token is invalid or expired.", flash[:alert]
  end

  test "should redirect for expired reset token" do
    @person.generate_password_reset_token!
    @person.update_column(:reset_password_sent_at, 3.hours.ago)
    
    get edit_password_reset_path(@person.reset_password_token)
    
    assert_redirected_to new_password_reset_path
    assert_equal "Password reset token is invalid or expired.", flash[:alert]
  end

  test "should update password for person with valid token" do
    @person.generate_password_reset_token!
    
    patch password_reset_path(@person.reset_password_token), params: {
      password: "newpassword123"
    }
    
    @person.reload
    assert @person.authenticate("newpassword123")
    assert_nil @person.reset_password_token
    assert_equal @person.id, session[:person_id]
    assert_redirected_to edit_person_path(id: @person.id)
    assert_equal "Your password has been reset!", flash[:notice]
  end

  test "should update password for admin with valid token" do
    @admin.generate_password_reset_token!
    
    patch password_reset_path(@admin.reset_password_token), params: {
      password: "newpassword123"
    }
    
    @admin.reload
    assert @admin.authenticate("newpassword123")
    assert_nil @admin.reset_password_token
    assert_equal @admin.id, session[:admin_id]
    assert_redirected_to root_path
    assert_equal "Your password has been reset!", flash[:notice]
  end

  test "should complete signup flow with password reset" do
    new_person = Person.create!(
      first_name: "Jane",
      last_name: "Smith",
      signup_completed: false
    )
    Contact.create!(
      email: "jane@example.com",
      person: new_person,
      primary: true
    )
    new_person.generate_password_reset_token!
    
    patch password_reset_path(new_person.reset_password_token), params: {
      password: "newpassword123",
      signup: "true"
    }
    
    new_person.reload
    assert new_person.authenticate("newpassword123")
    assert_nil new_person.reset_password_token
    assert_equal true, new_person.signup_completed
    assert_equal new_person.id, session[:person_id]
    assert_redirected_to membership_renewal_path(id: new_person.id)
    assert_equal "Your password has been set!  Please complete the payment process below to activate your membership.", flash[:notice]
  end
end
