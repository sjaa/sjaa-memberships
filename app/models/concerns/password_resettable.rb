module PasswordResettable extend ActiveSupport::Concern
    # Generates a unique token for password reset
    def generate_password_reset_token!
      self.reset_password_token = SecureRandom.urlsafe_base64
      self.reset_password_sent_at = Time.zone.now
      save!
    end
  
    # Checks if the password reset token is still valid (e.g., within 2 hours)
    def password_reset_token_valid?
      reset_password_sent_at && reset_password_sent_at >= 2.hours.ago
    end
  
    # Resets the password
    def reset_password!(new_password)
      self.password = new_password
      self.reset_password_token = nil
      save!
    end
end