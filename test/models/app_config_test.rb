require "test_helper"

class AppConfigTest < ActiveSupport::TestCase
  test "should create config with valid attributes" do
    config = AppConfig.new(
      key: "test_key",
      value: "test_value",
      category: "smtp",
      description: "Test configuration"
    )
    assert config.save
  end

  test "should require key" do
    config = AppConfig.new(value: "test", category: "smtp")
    assert_not config.save
    assert_includes config.errors[:key], "can't be blank"
  end

  test "should require unique key" do
    AppConfig.create!(key: "unique_key", value: "test", category: "smtp")
    duplicate = AppConfig.new(key: "unique_key", value: "test2", category: "smtp")
    assert_not duplicate.save
  end

  test "should get config value by key" do
    AppConfig.create!(key: "test_get", value: "test_value", category: "smtp")
    assert_equal "test_value", AppConfig.get("test_get")
  end

  test "should return nil for missing config" do
    assert_nil AppConfig.get("nonexistent_key")
  end

  test "should raise error for required missing config" do
    assert_raises RuntimeError do
      AppConfig.get("nonexistent_key", required: true)
    end
  end

  test "should set config value" do
    AppConfig.set("new_key", "new_value", category: "smtp", description: "Test")
    assert_equal "new_value", AppConfig.get("new_key")
  end

  test "should update existing config value" do
    AppConfig.create!(key: "update_key", value: "old_value", category: "smtp")
    AppConfig.set("update_key", "new_value")
    assert_equal "new_value", AppConfig.get("update_key")
  end

  test "should return configs for category" do
    AppConfig.create!(key: "smtp_1", value: "value1", category: "smtp")
    AppConfig.create!(key: "smtp_2", value: "value2", category: "smtp")
    AppConfig.create!(key: "paypal_1", value: "value3", category: "paypal")

    smtp_configs = AppConfig.for_category("smtp")
    assert_equal 2, smtp_configs.count
    assert smtp_configs.all? { |c| c.category == "smtp" }
  end

  test "should return smtp settings as hash" do
    AppConfig.create!(key: "smtp_address", value: "smtp.example.com", category: "smtp")
    AppConfig.create!(key: "smtp_port", value: "587", category: "smtp")
    AppConfig.create!(key: "smtp_domain", value: "example.com", category: "smtp")

    settings = AppConfig.smtp_settings
    assert_equal "smtp.example.com", settings[:address]
    assert_equal 587, settings[:port]
    assert_equal "example.com", settings[:domain]
    assert_equal :login, settings[:authentication]
  end

  test "encrypted attribute should be true when encrypted is true" do
    config = AppConfig.create!(
      key: "encrypted_test",
      value: "secret",
      category: "smtp",
      encrypted: true
    )
    assert config.encrypted?
  end

  test "should cache config values" do
    # Enable caching for this test
    original_cache = Rails.cache
    Rails.cache = ActiveSupport::Cache::MemoryStore.new

    config = AppConfig.create!(key: "cache_test", value: "cached_value", category: "smtp")

    # First call should hit database
    value1 = AppConfig.get("cache_test")
    assert_equal "cached_value", value1

    # Change value directly in database (bypasses callbacks)
    config.update_column(:value, "new_cached_value")

    # Second call should return cached value
    value2 = AppConfig.get("cache_test")
    assert_equal "cached_value", value2

    # Clear cache and should get new value
    AppConfig.clear_cache("cache_test")
    value3 = AppConfig.get("cache_test")
    assert_equal "new_cached_value", value3
  ensure
    # Restore original cache for other tests
    Rails.cache = original_cache
  end

  test "should clear cache after save" do
    config = AppConfig.create!(key: "auto_clear", value: "old", category: "smtp")
    assert_equal "old", AppConfig.get("auto_clear")

    config.update!(value: "new")
    assert_equal "new", AppConfig.get("auto_clear")
  end
end
