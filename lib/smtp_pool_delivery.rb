# lib/smtp_pool_delivery.rb
require_relative '../app/services/smtp_connection_pool'

class SmtpPoolDelivery
  def initialize(settings)
    @settings = settings
  end

  def deliver!(mail)
    SmtpConnectionPool.instance.with_connection do |smtp|
      # Ensure connection is still alive
      unless smtp.started?
        smtp.start(
          @settings[:domain],
          @settings[:user_name],
          @settings[:password],
          @settings[:authentication]
        )
      end

      smtp.send_message(mail.encoded, mail.from.to_s, mail.destinations)
    end
  rescue Net::SMTPError => e
    # Handle SMTP errors, potentially recreating the connection
    Rails.logger.error "SMTP Error: #{e.message}"
    raise
  end
end