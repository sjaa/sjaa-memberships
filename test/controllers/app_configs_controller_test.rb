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

  test "should show seed button when configs are empty" do
    AppConfig.destroy_all
    get app_configs_url
    assert_response :success
    assert_select "input[type=submit][value*='Initialize Configuration']"
  end

  test "should not show seed button when configs exist" do
    AppConfig.create!(key: 'test_key', value: 'test', category: 'smtp', description: 'Test')
    get app_configs_url
    assert_response :success
    assert_select "input[type=submit][value*='Initialize Configuration']", count: 0
  end

  test "should seed all configs from environment variables" do
    AppConfig.destroy_all

    # Set some environment variables
    ENV['SMTP_ADDRESS'] = 'test.smtp.com'
    ENV['SMTP_PORT'] = '2525'

    post seed_from_env_app_configs_url
    assert_redirected_to app_configs_url

    # Verify configs were created
    assert_equal 13, AppConfig.count
    assert_equal 'test.smtp.com', AppConfig.get('smtp_address')
    assert_equal '2525', AppConfig.get('smtp_port')

    # Verify default values for unset env vars
    assert_equal 'sjaa.net', AppConfig.get('smtp_domain')
  ensure
    # Clean up environment variables
    ENV.delete('SMTP_ADDRESS')
    ENV.delete('SMTP_PORT')
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
end
