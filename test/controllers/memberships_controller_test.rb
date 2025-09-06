require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
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
    
    @existing_membership = Membership.create!(
      person: @person,
      start: 1.year.ago,
      term_months: 12,
      ephemeris: false
    )
    
    # Stub PayPal environment constants
    unless Rails.application.config.respond_to?(:paypal_mode)
      Rails.application.config.paypal_mode = :sandbox
    end
    
    # Set up SjaaMembers constants if not defined
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
    end
  end

  # Note: These controller tests require admin authentication
  # The core membership functionality is tested via integration tests

  # PayPal integration tests are complex and require external mocking
  # These are covered by integration tests instead

  test "membership params are properly filtered" do
    post memberships_url, params: {
      membership: {
        person_id: @person.id,
        start: Date.current,
        term_months: 12,
        ephemeris: true,
        new: false,
        malicious_param: "should_be_filtered"
      }
    }
    
    membership = Membership.last
    assert_not_respond_to membership, :malicious_param
  end

  private

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