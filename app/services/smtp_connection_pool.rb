# app/services/smtp_connection_pool.rb
class SmtpConnectionPool
  include Singleton

  def initialize
    @pool = ConnectionPool.new(size: smtp_settings[:pool_size], timeout: smtp_settings[:pool_timeout]) do
      create_smtp_connection
    end
  end

  def with_connection(&block)
    @pool.with do |smtp|
      # Health check - ensure connection is still valid
      smtp = recreate_connection_if_needed(smtp)
      yield(smtp)
    end
  rescue => e
    Rails.logger.error "SMTP Pool Error: #{e.message}"
    raise
  end

  private

  def create_smtp_connection
    smtp = Net::SMTP.new(smtp_settings[:address], smtp_settings[:port])
    smtp.enable_starttls_auto if smtp_settings[:enable_starttls_auto]
    
    smtp.start(
      smtp_settings[:domain],
      smtp_settings[:user_name],
      smtp_settings[:password],
      smtp_settings[:authentication]
    )
    
    smtp
  end

  def recreate_connection_if_needed(smtp)
    return create_smtp_connection unless smtp&.started?
    
    # Simple health check
    begin
      smtp.rset # Send a reset command to test connection
      smtp
    rescue
      Rails.logger.info "Recreating SMTP connection due to health check failure"
      smtp.finish rescue nil
      create_smtp_connection
    end
  end

  def smtp_settings
    @smtp_settings ||= Rails.application.config.action_mailer.smtp_pool_settings
  end
end