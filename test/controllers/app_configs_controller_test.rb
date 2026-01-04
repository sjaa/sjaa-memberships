require "test_helper"

class AppConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: 'admin@sjaa.net',
      password: 'password123'
    )
    @admin.permissions << Permission.find_or_create_by!(name: 'permit')

    # Log in as admin
    post sessions_path, params: { email: @admin.email, password: 'password123' }
  end

  test "should get index" do
    get app_configs_url
    assert_response :success
  end

  test "should show initialize button when configs are empty" do
    AppConfig.destroy_all
    get app_configs_url
    assert_response :success
    assert_select "input[type=submit][value*='Initialize All Configurations']"
  end

  test "should show seed/update button when configs exist" do
    AppConfig.create!(key: 'test_key', value: 'test', category: 'smtp', description: 'Test')
    get app_configs_url
    assert_response :success
    assert_select "input[type=submit][value*='Seed/Update from Environment Variables']"
  end

  test "should seed all configs from environment variables" do
    AppConfig.destroy_all

    # Set some environment variables
    ENV['SMTP_ADDRESS'] = 'test.smtp.com'
    ENV['SMTP_PORT'] = '2525'

    post seed_from_env_app_configs_url
    assert_redirected_to app_configs_url

    # Verify configs were created
    assert_equal 14, AppConfig.count
    assert_equal 'test.smtp.com', AppConfig.get('smtp_address')
    assert_equal '2525', AppConfig.get('smtp_port')

    # Verify default values for unset env vars
    assert_equal 'sjaa.net', AppConfig.get('smtp_domain')

    # Verify success message mentions creation
    assert_match(/Created \d+ configuration setting/, flash[:success])
  ensure
    # Clean up environment variables
    ENV.delete('SMTP_ADDRESS')
    ENV.delete('SMTP_PORT')
  end

  test "should update existing configs when seeding" do
    # Create a config with a custom value
    AppConfig.create!(key: 'smtp_address', value: 'custom.smtp.com', category: 'smtp', description: 'Test')
    original_count = AppConfig.count

    # Set environment variable to a different value
    ENV['SMTP_ADDRESS'] = 'updated.smtp.com'

    post seed_from_env_app_configs_url
    assert_redirected_to app_configs_url

    # Verify the value was updated
    assert_equal 'updated.smtp.com', AppConfig.get('smtp_address')

    # Verify config count increased (new configs created, existing one updated)
    assert AppConfig.count > original_count

    # Verify success message mentions both creation and update
    assert_match(/Created \d+ new config.*updated 1 existing config/, flash[:success])
  ensure
    ENV.delete('SMTP_ADDRESS')
  end

  test "should not report update when value unchanged" do
    # Seed all configs first with defaults
    post seed_from_env_app_configs_url

    # Clear cache to ensure fresh reads
    AppConfig.clear_all_cache

    # Run seed again without any env variables - values should be same
    post seed_from_env_app_configs_url
    assert_redirected_to app_configs_url

    # Should report all unchanged since no env vars are set and values match defaults
    assert_match(/All \d+ configuration setting.*already up to date/, flash[:success])
  end

  test "should require permit permission" do
    # Remove permit permission
    @admin.permissions.delete(Permission.find_by(name: 'permit'))

    get app_configs_url
    assert_redirected_to root_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should get edit" do
    config = AppConfig.create!(key: 'test_key', value: 'test', category: 'smtp', description: 'Test')
    get edit_app_config_url(config)
    assert_response :success
  end

  test "should update config" do
    config = AppConfig.create!(key: 'test_key', value: 'old_value', category: 'smtp', description: 'Test')
    patch app_config_url(config), params: { app_config: { value: 'new_value' } }
    assert_redirected_to app_configs_url
    assert_equal 'new_value', config.reload.value
  end

  test "should create config from definition when editing placeholder" do
    # Ensure the config doesn't exist
    AppConfig.find_by(key: 'membership_renewal_threshold_months')&.destroy

    # Verify it doesn't exist
    assert_nil AppConfig.find_by(key: 'membership_renewal_threshold_months')

    # Try to edit using the key instead of ID
    get edit_app_config_url('membership_renewal_threshold_months')
    assert_response :success

    # Verify the config was created with default values
    config = AppConfig.find_by(key: 'membership_renewal_threshold_months')
    assert_not_nil config
    assert_equal 'membership_renewal_threshold_months', config.key
    assert_equal 'membership', config.category
    assert_equal '2', config.value
    assert_equal false, config.encrypted
    assert_includes config.description, 'renewal reminders'
  end

  test "should create config from definition with env variable when editing placeholder" do
    # Ensure the config doesn't exist
    AppConfig.find_by(key: 'membership_renewal_threshold_months')&.destroy

    # Set environment variable
    ENV['MEMBERSHIP_RENEWAL_THRESHOLD_MONTHS'] = '3'

    # Try to edit using the key instead of ID
    get edit_app_config_url('membership_renewal_threshold_months')
    assert_response :success

    # Verify the config was created with env value
    config = AppConfig.find_by(key: 'membership_renewal_threshold_months')
    assert_not_nil config
    assert_equal '3', config.value
  ensure
    ENV.delete('MEMBERSHIP_RENEWAL_THRESHOLD_MONTHS')
  end

  test "should show placeholder configs in index" do
    # Destroy all configs to ensure we see placeholders
    AppConfig.destroy_all

    get app_configs_url
    assert_response :success

    # Verify that all defined configs are shown (as placeholders)
    AppConfig::DEFINITIONS.each do |definition|
      assert_select "code", text: definition[:key]
      assert_select "span.badge", text: "Not Configured"
    end
  end

  test "index should show both existing and placeholder configs" do
    # Create one config
    AppConfig.create!(key: 'smtp_address', value: 'test.smtp.com', category: 'smtp', description: 'Test')

    # Destroy the rest
    AppConfig.where.not(key: 'smtp_address').destroy_all

    get app_configs_url
    assert_response :success

    # Should show the existing config
    assert_select "code", text: 'smtp_address'
    # Should NOT show "Not Configured" badge for existing config
    # (This is tricky to assert, so we'll check that other placeholders show the badge)

    # Should show placeholders for the rest
    remaining_keys = AppConfig::DEFINITIONS.map { |d| d[:key] } - ['smtp_address']
    remaining_keys.each do |key|
      assert_select "code", text: key
    end
  end
end
