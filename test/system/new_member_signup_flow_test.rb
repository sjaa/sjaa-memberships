require "application_system_test_case"

class NewMemberSignupFlowTest < ApplicationSystemTestCase
  setup do
    @referral = Referral.create!(name: 'internet', description: 'Web search')
    
    # Set up constants if not defined
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
    end
  end

  test "new member can complete full signup flow" do
    visit signup_path

    # Fill out signup form
    fill_in "first_name", with: "Jane"
    fill_in "last_name", with: "Smith"
    fill_in "email", with: "jane@example.com"
    fill_in "password", with: "newpassword123"
    click_on "Sign Up"

    # Should redirect to login page with notice
    assert_text "Please check your email to complete signup"
    assert_current_path login_path

    # Simulate following the email confirmation link
    # The signup creates an encrypted token, so we need to get it from the email
    # For testing, we'll create a mock token
    token = SignupToken.encode(
      first_name: "Jane",
      last_name: "Smith",
      email: "jane@example.com",
      password: "newpassword123",
      expires_at: DateTime.now + 1.hour
    )

    visit signup_response_path(token: token)

    # Should redirect to membership renewal with confirmation message
    assert_text "Your password has been set and email confirmed!"
    assert_text "Please complete the payment process"

    # Verify person was created and session is set
    person = Person.find_by(first_name: "Jane", last_name: "Smith")
    assert_not_nil person
    # Verify we're on the membership renewal page (session verification)
    assert_current_path membership_renewal_path(id: person.id)
  end

  test "new member signup handles existing email appropriately" do
    # Create existing person
    existing_person = Person.create!(
      first_name: "John",
      last_name: "Doe",
      password: "password123",
    )
    Contact.create!(
      email: "john@example.com",
      person: existing_person,
      primary: true
    )

    visit signup_path

    fill_in "first_name", with: "Jane"
    fill_in "last_name", with: "Smith"
    fill_in "email", with: "john@example.com"  # Use existing email
    fill_in "password", with: "newpassword123"
    click_on "Sign Up"

    # Should redirect to login with error message
    assert_text "already registered"
    assert_text "Please log in or reset your password"
    assert_current_path login_path
  end

  test "new member can view membership renewal options" do
    # Create person in signup state
    person = Person.create!(
      first_name: "Jane",
      last_name: "Smith",
      password: "password123"
    )
    Contact.create!(
      email: "jane@example.com",
      person: person,
      primary: true
    )
    
    # Login as the person and visit membership renewal page
    login_as("jane@example.com", "password123")
    visit membership_renewal_path(id: person.id)
    
    # Should show membership options
    assert_text "Membership Payment"
    assert_text "Membership Fee" # Base membership rate section
    
    # Check for ephemeris option
    assert_text "Ephemeris"
    
    # Check for donation option
    assert_text "Donation"
  end

  test "new member membership renewal shows correct pricing" do
    person = Person.create!(
      first_name: "Jane",
      last_name: "Smith", 
      password: "password123"
    )
    Contact.create!(
      email: "jane@example.com",
      person: person,
      primary: true
    )
    
    # Login as the person and visit membership renewal page
    login_as("jane@example.com", "password123")
    visit membership_renewal_path(id: person.id)

    # Base membership should be displayed
    assert_text "Membership Fee"

    # Check form fields with correct names
    select "Printed +$#{SjaaMembers::EPHEMERIS_FEE}", from: "membership[ephemeris_amount]"
    fill_in "membership[donation_amount]", with: "25"

    # Verify form elements are present
    assert_text "Extra Donation"
    assert_text "Ephemeris"
  end

  test "lifetime member cannot access renewal page" do
    # Create lifetime member
    person = Person.create!(
      first_name: "Life",
      last_name: "Member",
      password: "password123"
    )
    Contact.create!(
      email: "life@example.com",
      person: person,
      primary: true
    )
    
    # Create lifetime membership
    Membership.create!(
      person: person,
      start: Date.current,
      term_months: nil  # lifetime membership
    )
    
    # Login as the lifetime member
    login_as("life@example.com", "password123")
    visit membership_renewal_path(id: person.id)

    assert_text "LIFETIME member"
    assert_text "no need to renew"
  end

  test "new member signup validates required fields" do
    visit signup_path

    # Try to submit without required fields
    click_on "Sign Up"

    # Should redirect back to signup with error message
    assert_text "Please fill in *all* fields"
    assert_current_path signup_path
  end

  test "clicking confirmation link twice does not create duplicate person" do
    visit signup_path

    # Fill out signup form
    fill_in "first_name", with: "Bob"
    fill_in "last_name", with: "Jones"
    fill_in "email", with: "bob@example.com"
    fill_in "password", with: "password123"
    click_on "Sign Up"

    # Should redirect to login page with notice
    assert_text "Please check your email to complete signup"
    assert_current_path login_path

    # Create token for confirmation
    token = SignupToken.encode(
      first_name: "Bob",
      last_name: "Jones",
      email: "bob@example.com",
      password: "password123",
      expires_at: DateTime.now + 1.hour
    )

    # Click confirmation link first time
    visit signup_response_path(token: token)

    # Should create person and redirect to membership renewal
    assert_text "Your password has been set and email confirmed!"
    person = Person.find_by(first_name: "Bob", last_name: "Jones")
    assert_not_nil person
    assert_current_path membership_renewal_path(id: person.id)

    # Log out
    visit logout_path

    # Click confirmation link again (simulate duplicate click)
    visit signup_response_path(token: token)

    # Should redirect to login with error message, not create duplicate
    assert_text "already exists"
    assert_text "Please log in to continue"
    assert_current_path login_path

    # Verify only one person was created
    assert_equal 1, Person.where(first_name: "Bob", last_name: "Jones").count
  end



  private

  def stub_const(const_name, value)
    # Simple constant stubbing for tests
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
    # Fallback - just define at Object level for tests
    Object.const_set(const_name.gsub('::', '_'), value) unless Object.const_defined?(const_name.gsub('::', '_'))
  end
end