# Load SMTP settings from AppConfig model
# This runs after the database is connected and allows dynamic configuration

Rails.application.configure do
  # Defer SMTP configuration until after application initialization
  # This ensures the database is connected and AppConfig is available
  config.after_initialize do
    begin
      # Load SMTP settings from database if available
      smtp_settings = AppConfig.smtp_settings

      # Only configure if we have valid settings
      if smtp_settings[:address].present?
        config.action_mailer.smtp_pool_settings = {
          pool_size: 1,
          pool_timeout: 10,
          **smtp_settings
        }
        Rails.logger.info "SMTP settings loaded from AppConfig"
      else
        Rails.logger.warn "SMTP settings not configured in AppConfig"
      end
    rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
      # Database not ready yet (e.g., during migrations)
      Rails.logger.warn "Skipping SMTP configuration: #{e.message}"
    end
  end
end
