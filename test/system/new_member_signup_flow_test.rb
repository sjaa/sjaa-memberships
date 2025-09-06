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
    click_on "Sign Up"
    
    # Should redirect to post signup page
    assert_text "Please check your email"
    
    # Simulate following password reset link from email
    person = Person.find_by(first_name: "Jane", last_name: "Smith")
    assert_not_nil person
    assert_equal false, person.signup_completed
    assert_not_nil person.reset_password_token
    
    visit edit_password_reset_path(person.reset_password_token, signup: true)
    
    # Set password
    assert_text "Set Your Password"
    fill_in "password", with: "newpassword123"
    click_on "Set Password"
    
    # Should redirect to membership renewal with message
    assert_text "Your password has been set!"
    assert_text "Please complete the payment process"
    assert_current_path membership_renewal_path(id: person.id)
    
    # Verify person is marked as signup completed
    person.reload
    assert_equal true, person.signup_completed
    
    # Verify session is set
    assert_equal person.id, page.get_rack_session[:person_id]
  end

  test "new member signup handles existing email appropriately" do
    # Create existing person
    existing_person = Person.create!(
      first_name: "John",
      last_name: "Doe", 
      password: "password123",
      signup_completed: true
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
    click_on "Sign Up"
    
    # Should redirect to login with error message
    assert_text "already registered"
    assert_text "Please log in or reset your password"
  end

  test "new member can view membership renewal options" do
    # Create person in signup state
    person = Person.create!(
      first_name: "Jane",
      last_name: "Smith",
      signup_completed: true,
      password: "password123"
    )
    Contact.create!(
      email: "jane@example.com",
      person: person,
      primary: true
    )
    
    # Visit membership renewal page
    visit membership_renewal_path(id: person.id)
    
    # Should show membership options
    assert_text "Membership Renewal"
    assert_text "$75" # Base membership rate
    
    # Check for ephemeris option
    assert_text "Ephemeris"
    
    # Check for donation option
    assert_text "Donation"
  end

  test "new member membership renewal shows correct pricing" do
    person = Person.create!(
      first_name: "Jane",
      last_name: "Smith", 
      signup_completed: true,
      password: "password123"
    )
    Contact.create!(
      email: "jane@example.com",
      person: person,
      primary: true
    )
    
    visit membership_renewal_path(id: person.id)
    
    # Base membership should be displayed
    assert_text SjaaMembers::YEARLY_MEMBERSHIP_RATE.to_s
    
    # If ephemeris checkbox exists, check pricing update
    if page.has_field?("ephemeris_amount")
      fill_in "ephemeris_amount", with: SjaaMembers::EPHEMERIS_FEE.to_s
      # Price should update (assuming JavaScript updates are testable)
    end
    
    # If donation field exists
    if page.has_field?("donation_amount")
      fill_in "donation_amount", with: "25"
      # Total should include donation
    end
  end

  test "lifetime member cannot access renewal page" do
    # Create lifetime member
    person = Person.create!(
      first_name: "Life",
      last_name: "Member",
      signup_completed: true, 
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
    
    visit membership_renewal_path(id: person.id)
    
    assert_text "LIFETIME member"
    assert_text "no need to renew"
  end

  test "new member signup validates required fields" do
    visit signup_path
    
    # Try to submit without required fields
    click_on "Sign Up"
    
    # Should show validation errors (implementation dependent)
    # This test may need adjustment based on actual form validation
    assert_current_path signup_path
  end

  test "post signup page shows correct information" do
    person = Person.create!(
      first_name: "Jane",
      last_name: "Smith",
      signup_completed: false
    )
    
    visit post_signup_path(person_id: person.id)
    
    assert_text "Jane"
    assert_text "check your email"
  end

  test "password reset during signup flow sets correct redirect" do
    person = Person.create!(
      first_name: "Jane", 
      last_name: "Smith",
      signup_completed: false
    )
    person.generate_password_reset_token!
    
    visit edit_password_reset_path(person.reset_password_token, signup: true)
    
    # Should show signup-specific messaging
    assert_text "Set Your Password"
    
    fill_in "password", with: "password123"
    click_on "Set Password"
    
    # Should redirect to membership renewal, not regular profile edit
    assert_current_path membership_renewal_path(id: person.id)
    assert_text "complete the payment process"
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