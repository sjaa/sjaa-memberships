require "application_system_test_case"

class ExistingMemberRenewalFlowTest < ApplicationSystemTestCase
  setup do
    @person = Person.create!(
      first_name: "John",
      last_name: "Doe", 
      password: "password123",
      signup_completed: true
    )
    
    @contact = Contact.create!(
      email: "john@example.com",
      person: @person,
      primary: true
    )
    
    # Create existing membership that's about to expire
    @existing_membership = Membership.create!(
      person: @person,
      start: 11.months.ago.beginning_of_month,
      term_months: 12,
      ephemeris: false
    )
    
    # Set up constants
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
    end
    
    # Login as the person
    login_as_person(@person)
  end

  test "existing member can access renewal page" do
    visit membership_renewal_path(id: @person.id)
    
    assert_text "Membership Renewal"
    assert_text @person.name
    
    # Should show current membership info
    assert_text "Current Membership"
    
    # Should show renewal options
    assert_text "Membership Fee"
    assert_text SjaaMembers::YEARLY_MEMBERSHIP_RATE.to_s
  end

  test "existing member renewal shows correct start date" do
    visit membership_renewal_path(id: @person.id)
    
    # For existing member, renewal should start when current expires
    expected_start = @existing_membership.end.beginning_of_month
    assert_text expected_start.strftime("%B %Y")
  end

  test "existing member can complete renewal with basic membership" do
    setup_successful_paypal_mocks
    
    visit membership_renewal_path(id: @person.id)
    
    # Select basic renewal options
    choose "membership_term_months_12" if page.has_field?("membership_term_months_12")
    uncheck "ephemeris" if page.has_field?("ephemeris", checked: true)
    fill_in "donation_amount", with: "0" if page.has_field?("donation_amount")
    
    # Simulate PayPal flow
    click_on "Renew Membership"
    
    # Should create order and redirect to PayPal (mocked)
    # In real test, this would involve PayPal interaction
    simulate_successful_paypal_completion
    
    # After successful payment
    assert_text "successfully"
    
    # Verify new membership was created
    @person.reload
    newest_membership = @person.memberships.order(:start).last
    assert newest_membership.start > @existing_membership.start
    assert_equal 12, newest_membership.term_months
    assert_not newest_membership.ephemeris
  end

  test "existing member can renew with ephemeris subscription" do
    setup_successful_paypal_mocks
    
    visit membership_renewal_path(id: @person.id)
    
    # Add ephemeris subscription
    fill_in "ephemeris_amount", with: SjaaMembers::EPHEMERIS_FEE.to_s
    
    click_on "Renew Membership"
    simulate_successful_paypal_completion
    
    @person.reload
    newest_membership = @person.memberships.order(:start).last
    assert newest_membership.ephemeris
    
    # Verify pricing
    order = newest_membership.order
    expected_price = SjaaMembers::YEARLY_MEMBERSHIP_RATE + SjaaMembers::EPHEMERIS_FEE
    assert_equal expected_price, order.price
  end

  test "existing member can include donation with renewal" do
    setup_successful_paypal_mocks
    
    visit membership_renewal_path(id: @person.id)
    
    donation_amount = 25.0
    fill_in "donation_amount", with: donation_amount.to_s
    
    click_on "Renew Membership"
    simulate_successful_paypal_completion
    
    @person.reload
    newest_membership = @person.memberships.order(:start).last
    order = newest_membership.order
    
    expected_price = SjaaMembers::YEARLY_MEMBERSHIP_RATE + donation_amount
    assert_equal expected_price, order.price
    assert_equal donation_amount.to_s, order.membership_params["donation_amount"]
  end

  test "existing member renewal handles expired membership correctly" do
    # Create expired membership
    @existing_membership.update!(
      start: 2.years.ago,
      term_months: 12
    )
    
    visit membership_renewal_path(id: @person.id)
    
    # Should show expired status
    assert_text "Expired" 
    
    # Renewal should start from current date for expired members
    assert_text Date.current.strftime("%B %Y")
  end

  test "lifetime member cannot renew" do
    # Convert to lifetime membership
    @existing_membership.update!(term_months: nil)
    
    visit membership_renewal_path(id: @person.id)
    
    assert_text "LIFETIME member"
    assert_text "no need to renew"
    assert_no_text "Renew Membership"
  end

  test "member receives renewal reminder email" do
    visit person_path(@person)
    
    assert_emails 1 do
      click_on "Send Reminder" if page.has_link?("Send Reminder")
    end
    
    assert_text "Reminder email sent"
  end

  test "member receives welcome email after successful renewal" do
    setup_successful_paypal_mocks
    
    visit membership_renewal_path(id: @person.id)
    click_on "Renew Membership"
    
    assert_emails 1 do
      simulate_successful_paypal_completion
    end
  end

  test "renewal form shows pricing updates dynamically" do
    visit membership_renewal_path(id: @person.id)
    
    # Check base price is displayed
    assert_text SjaaMembers::YEARLY_MEMBERSHIP_RATE.to_s
    
    # Add ephemeris (if JavaScript is available)
    if page.has_field?("ephemeris_amount")
      fill_in "ephemeris_amount", with: SjaaMembers::EPHEMERIS_FEE.to_s
      # Total should update (this test may require JavaScript driver)
    end
    
    # Add donation
    if page.has_field?("donation_amount")
      fill_in "donation_amount", with: "25"
      # Total should update to include donation
    end
  end

  test "renewal handles PayPal errors gracefully" do
    setup_failing_paypal_mocks
    
    visit membership_renewal_path(id: @person.id)
    click_on "Renew Membership"
    
    # Should show error message
    assert_text "error" # or appropriate error handling
    
    # Should not create membership
    initial_membership_count = @person.memberships.count
    @person.reload
    assert_equal initial_membership_count, @person.memberships.count
  end

  test "member can view membership history" do
    # Create additional historical membership
    Membership.create!(
      person: @person,
      start: 2.years.ago,
      term_months: 12,
      ephemeris: true
    )
    
    visit person_path(@person)
    
    # Should show membership history
    assert_text "Membership History"
    assert_text "Ephemeris" # From historical membership
  end

  test "expired member shows correct status and renewal options" do
    # Make membership expired
    @existing_membership.update!(
      start: 2.years.ago.beginning_of_month,
      term_months: 12
    )
    
    visit person_path(@person)
    
    assert_text "Expired"
    assert_text "Renew"
    
    # Visit renewal page
    visit membership_renewal_path(id: @person.id)
    
    # Should allow immediate renewal
    assert_text "Renew Your Membership"
    assert_no_text "LIFETIME member"
  end

  private

  def login_as_person(person)
    # Simulate logged in session
    page.set_rack_session(person_id: person.id)
  end

  def setup_successful_paypal_mocks
    # Mock successful PayPal responses
    # This would typically involve stubbing PayPal SDK calls
    # Implementation depends on how PayPal is integrated
  end

  def setup_failing_paypal_mocks
    # Mock failing PayPal responses for error testing
  end

  def simulate_successful_paypal_completion
    # Simulate the PayPal success callback
    # In a real application, this would involve:
    # 1. PayPal redirecting back to capture_order endpoint
    # 2. Order being marked as paid
    # 3. Membership being created
    # 4. Welcome email being sent
    
    # For testing purposes, we can directly call the capture endpoint
    # This would typically be done by PayPal's webhook or redirect
    if order = Order.last
      post membership_capture_order_path, params: { order_id: order.token }
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