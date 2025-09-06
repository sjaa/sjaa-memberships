ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all  # Commented out to avoid fixture conflicts, create data in tests as needed

  # Add more helper methods to be used by all tests here...
  
  # Set up constants for testing if they don't exist
  def setup_test_constants
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
    end
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

class ActionDispatch::IntegrationTest
  include ActiveSupport::Testing::TimeHelpers
  
  # Add integration test helpers here
  def login_as_admin(admin)
    post login_path, params: { email: admin.email, password: 'password123' }
  end
  
  def login_as_person(person)
    post login_path, params: { email: person.email, password: 'password123' }
  end
end

# Set up test environment configurations
Rails.application.configure do
  # Use test-specific PayPal mode
  config.paypal_mode = :sandbox
  
  # Set default URL host for mailers
  config.action_mailer.default_url_options = { host: 'test.example.com' }
end

# Mock external service calls in test environment
require 'webmock/minitest' if defined?(WebMock)

# Disable external HTTP requests except for localhost
if defined?(WebMock)
  WebMock.disable_net_connect!(allow_localhost: true)
end