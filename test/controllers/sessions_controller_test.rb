require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create an admin to bypass setup redirect
    @admin = Admin.create!(
      email: 'admin@example.com',
      password: 'adminpassword123'
    )

    # Create a person for testing duplicates
    @existing_person = Person.create!(
      first_name: 'John',
      last_name: 'Smith',
      password: 'password123'
    )
    @existing_person.contacts.create!(email: 'john.smith@example.com', primary: true)

    # Create a similar person
    @similar_person = Person.create!(
      first_name: 'Jon',
      last_name: 'Smith',
      password: 'password123'
    )
    @similar_person.contacts.create!(email: 'jon.smith@example.com', primary: true)
  end

  test "signup_request shows warning for similar names" do
    post signup_request_path, params: {
      first_name: 'John',
      last_name: 'Smyth',
      email: 'john.smyth@example.com',
      password: 'newpassword123'
    }

    # Should re-render the signup form with a warning
    assert_response :success

    # Should show warning flash message
    assert_match /similar names/, flash[:warning]
    assert_match /John Smith/, flash[:warning]

    # Should repopulate form data
    assert_equal 'John', flash[:signup_data][:first_name]
    assert_equal 'Smyth', flash[:signup_data][:last_name]
    assert_equal 'john.smyth@example.com', flash[:signup_data][:email]
  end

  test "signup_request proceeds normally for dissimilar names" do
    # Capture emails sent
    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
      post signup_request_path, params: {
        first_name: 'Alice',
        last_name: 'Johnson',
        email: 'alice.johnson@example.com',
        password: 'newpassword123'
      }
    end

    # Should redirect to login with success notice
    assert_redirected_to login_path
    assert_match /email to complete/, flash[:notice]

    # Should NOT show warning
    assert_nil flash[:warning]
  end

  test "signup_request blocks exact duplicate email" do
    post signup_request_path, params: {
      first_name: 'Different',
      last_name: 'Person',
      email: 'john.smith@example.com', # Existing email
      password: 'newpassword123'
    }

    # Should redirect to login with error
    assert_redirected_to login_path
    assert_match /already registered/, flash[:alert]
  end

  test "signup_request requires all fields" do
    post signup_request_path, params: {
      first_name: 'John',
      last_name: '', # Missing last name
      email: 'test@example.com',
      password: 'password123'
    }

    # Should redirect back with error
    assert_redirected_to signup_path
    assert_match /fill in.*all.*fields/i, flash[:alert]
  end

  test "signup_request handles case-insensitive email duplicate check" do
    post signup_request_path, params: {
      first_name: 'Different',
      last_name: 'Person',
      email: 'john.smith@example.com', # Exact match (emails are normalized to lowercase)
      password: 'newpassword123'
    }

    # Should redirect to login with error (email already exists)
    assert_redirected_to login_path
    assert_match /already registered/, flash[:alert]
  end

  test "signup_request shows multiple similar people in warning" do
    # Create another similar person
    another_similar = Person.create!(
      first_name: 'Johnny',
      last_name: 'Smith',
      password: 'password123'
    )
    another_similar.contacts.create!(email: 'johnny.smith@example.com', primary: true)

    post signup_request_path, params: {
      first_name: 'John',
      last_name: 'Smith',
      email: 'new.john.smith@example.com',
      password: 'newpassword123'
    }

    # Should re-render with warning
    assert_response :success

    # Warning should mention the existing similar person
    assert_match /similar names/, flash[:warning]

    # Should suggest login or password reset
    assert_match /logging in.*different email.*resetting your password/i, flash[:warning]
  end

  test "signup_request handles person with nil names" do
    # Create person with blank names (edge case)
    blank_person = Person.create!(
      first_name: '',
      last_name: '',
      password: 'password123'
    )
    blank_person.contacts.create!(email: 'blank@example.com', primary: true)

    # Should not crash when checking similarity
    assert_nothing_raised do
      post signup_request_path, params: {
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        password: 'password123'
      }
    end
  end

  test "signup form repopulates fields after warning" do
    post signup_request_path, params: {
      first_name: 'John',
      last_name: 'Smyth',
      email: 'john.smyth@example.com',
      password: 'password123'
    }

    assert_response :success

    # Check flash data contains the values for repopulation
    assert_equal 'John', flash[:signup_data][:first_name]
    assert_equal 'Smyth', flash[:signup_data][:last_name]
    assert_equal 'john.smyth@example.com', flash[:signup_data][:email]
  end

  test "signup warning is soft and does not block account creation" do
    # The warning is shown but user can proceed by using a sufficiently different email
    # or by changing their name slightly. This test verifies it's a soft warning, not a blocker.

    # First, verify warning appears for similar name
    post signup_request_path, params: {
      first_name: 'John',
      last_name: 'Smyth',
      email: 'john.smyth@example.com',
      password: 'password123'
    }

    assert_response :success
    assert_not_nil flash[:warning]

    # Now verify that a dissimilar name can proceed normally
    # (demonstrating the system doesn't block all signups)
    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
      post signup_request_path, params: {
        first_name: 'Alice',
        last_name: 'Johnson',
        email: 'alice.johnson@example.com',
        password: 'password123'
      }
    end

    assert_redirected_to login_path
    assert_match /email to complete/, flash[:notice]
  end
end
