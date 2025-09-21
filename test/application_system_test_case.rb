require "test_helper"
require "capybara/rails"
require "capybara/minitest"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Try rack_test first, fall back to Chrome if needed
  if ENV['SYSTEM_TEST_DRIVER'] == 'chrome'
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |driver_option|
      driver_option.add_argument('--headless=new')
      driver_option.add_argument('--no-sandbox')
      driver_option.add_argument('--disable-dev-shm-usage')
      driver_option.add_argument('--disable-gpu')
      driver_option.add_argument('--window-size=1400,1400')
      driver_option.add_argument('--user-data-dir=/tmp/chrome-test-profile-' + SecureRandom.hex(8))
      driver_option.add_argument('--disable-extensions')
      driver_option.add_argument('--disable-plugins')
      driver_option.add_argument('--disable-images')
      driver_option.add_argument('--memory-pressure-off')
    end
  else
    driven_by :rack_test
  end

  # Setup any system test helpers here
  def setup
    setup_test_constants
  end

  private

  def setup_test_constants
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
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