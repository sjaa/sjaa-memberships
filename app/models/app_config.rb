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

  # Define all possible configurations with their defaults
  # This serves as the source of truth for what configs exist
  DEFINITIONS = [
    # SMTP Email Settings
    { key: 'smtp_address', category: 'smtp', description: 'SMTP server address', encrypted: false, default: 'smtp.gmail.com', env: 'SMTP_ADDRESS' },
    { key: 'smtp_port', category: 'smtp', description: 'SMTP server port', encrypted: false, default: '587', env: 'SMTP_PORT' },
    { key: 'smtp_domain', category: 'smtp', description: 'SMTP domain', encrypted: false, default: 'sjaa.net', env: 'SMTP_DOMAIN' },
    { key: 'smtp_user_name', category: 'smtp', description: 'SMTP username', encrypted: false, default: '', env: 'SMTP_USER_NAME' },
    { key: 'smtp_password', category: 'smtp', description: 'SMTP password (encrypted)', encrypted: true, default: '', env: 'SMTP_PASSWORD' },

    # PayPal Settings
    { key: 'paypal_client_id', category: 'paypal', description: 'PayPal client ID (encrypted)', encrypted: true, default: '', env: 'PAYPAL_CLIENT_ID' },
    { key: 'paypal_client_secret', category: 'paypal', description: 'PayPal client secret (encrypted)', encrypted: true, default: '', env: 'PAYPAL_CLIENT_SECRET' },

    # Google API Settings
    { key: 'google_web_client_base64', category: 'google', description: 'Base64 encoded Google OAuth client configuration (encrypted)', encrypted: true, default: '', env: 'GOOGLE_WEB_CLIENT_BASE64' },
    { key: 'google_members_group', category: 'google', description: 'Google Groups email for active members', encrypted: false, default: 'membership-app-test-group@sjaa.net', env: 'GOOGLE_MEMBERS_GROUP' },
    { key: 'google_remove_group', category: 'google', description: 'Google Groups email for expired members', encrypted: false, default: 'expired-members@sjaa.net', env: 'GOOGLE_REMOVE_GROUP' },
    { key: 'google_api_key', category: 'google', description: 'Google API key for calendar access (encrypted)', encrypted: true, default: '', env: 'SJAA_GOOGLE_API_KEY' },
    { key: 'google_all_events_calendar_id', category: 'google', description: 'Google Calendar ID for SJAA All Events calendar', encrypted: false, default: '', env: 'SJAA_ALL_EVENTS_CALENDAR_ID' },
    { key: 'google_merged_calendar_id', category: 'google', description: 'Google Calendar ID for SJAA Merged calendar (legacy)', encrypted: false, default: '', env: 'SJAA_MERGED_CALENDAR_ID' },

    # Membership Settings
    { key: 'membership_renewal_threshold_months', category: 'membership', description: 'Number of months before expiration to show renewal reminders and mark memberships as renewable', encrypted: false, default: '2', env: 'MEMBERSHIP_RENEWAL_THRESHOLD_MONTHS' }
  ].freeze

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

    # Find a config definition by key
    def definition_for(key)
      DEFINITIONS.find { |d| d[:key] == key }
    end

    # Get all config definitions grouped by category
    def all_definitions_by_category
      DEFINITIONS.group_by { |d| d[:category] }.sort_by { |k, _| k }
    end

    # Create a config from its definition with default or env value
    def create_from_definition(key)
      definition = definition_for(key)
      return nil unless definition

      value = ENV.fetch(definition[:env], definition[:default])

      create!(
        key: definition[:key],
        value: value,
        category: definition[:category],
        description: definition[:description],
        encrypted: definition[:encrypted]
      )
    end

    # Find or create a config by key using its definition
    def find_or_create_from_definition(key)
      find_by(key: key) || create_from_definition(key)
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
