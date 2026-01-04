# Application configuration model
# Stores app-wide settings in the database instead of environment variables
# Supports encrypted values for sensitive data like API keys
class AppConfig < ApplicationRecord
  # Only enable encryption if credentials are configured
  # In production, encryption will be used. In dev/test, it's optional.
  encryption_configured = begin
    Rails.application.credentials.active_record_encryption.present?
  rescue
    false
  end

  if encryption_configured
    encrypts :value, deterministic: false
  end

  validates :key, presence: true, uniqueness: true
  validates :category, presence: true
  validates :value, presence: true, allow_blank: true

  # Configuration categories
  CATEGORIES = {
    smtp: 'SMTP Email Settings (Requires Application Restart)',
    paypal: 'PayPal Payment Settings',
    google: 'Google API Settings',
    membership: 'Membership Settings'
  }.freeze

  # Cache configuration values in memory for performance
  class << self
    # Get a configuration value by key
    # Returns nil if not found or raises an error if required
    def get(key, required: false)
      config = Rails.cache.fetch("app_config/#{key}", expires_in: 5.minutes) do
        find_by(key: key)&.value
      end

      if required && config.nil?
        raise "Required configuration key '#{key}' not found"
      end

      config
    end

    # Set a configuration value by key
    def set(key, value, category: nil, description: nil, encrypted: false)
      config = find_or_initialize_by(key: key)
      config.value = value
      config.category = category if category
      config.description = description if description
      config.encrypted = encrypted
      config.save!
      clear_cache(key)
      config
    end

    # Get all settings for a category
    def for_category(category)
      where(category: category)
    end

    # Get SMTP settings as a hash for ActionMailer
    def smtp_settings
      {
        address: get('smtp_address'),
        port: get('smtp_port')&.to_i,
        domain: get('smtp_domain'),
        user_name: get('smtp_user_name'),
        password: get('smtp_password'),
        host: get('smtp_address'),
        authentication: :login,
        enable_starttls_auto: true
      }
    end

    # Get PayPal credentials
    def paypal_client_id
      get('paypal_client_id')
    end

    def paypal_client_secret
      get('paypal_client_secret')
    end

    # Get Google settings
    def google_web_client_base64
      get('google_web_client_base64')
    end

    def google_members_group
      get('google_members_group', required: false) || 'membership-app-test-group@sjaa.net'
    end

    def google_remove_group
      get('google_remove_group', required: false) || 'expired-members@sjaa.net'
    end

    def google_api_key
      get('google_api_key')
    end

    def google_all_events_calendar_id
      get('google_all_events_calendar_id')
    end

    def google_merged_calendar_id
      get('google_merged_calendar_id')
    end

    # For backward compatibility, prefer all_events, fall back to merged
    def google_calendar_id
      get('google_all_events_calendar_id') || get('google_merged_calendar_id')
    end

    # Get membership renewal threshold in months
    def membership_renewal_threshold_months
      (get('membership_renewal_threshold_months') || '2').to_i
    end

    # Clear cache for a specific key
    def clear_cache(key)
      Rails.cache.delete("app_config/#{key}")
    end

    # Clear all config caches
    def clear_all_cache
      find_each do |config|
        clear_cache(config.key)
      end
    end
  end

  # Instance method to mark as encrypted
  def encrypted?
    encrypted
  end

  # Clear cache after save
  after_save :clear_cache
  after_destroy :clear_cache

  # Skip updating encrypted values if blank
  before_validation :skip_blank_encrypted_values

  private

  def clear_cache
    self.class.clear_cache(key)
  end

  def skip_blank_encrypted_values
    if encrypted? && value.blank? && persisted?
      # Don't update the value if it's blank on an existing encrypted record
      restore_attributes(['value'])
    end
  end
end
