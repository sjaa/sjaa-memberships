class SignupToken
  def self.encryptor
    # Generate a secure key derived from your secret_key_base
    key = Rails.application.key_generator.generate_key('signup_tokens', 32)
    ActiveSupport::MessageEncryptor.new(key)
  end

  def self.encode(data)
    encryptor.encrypt_and_sign(data)
  end

  def self.decode(token)
    encryptor.decrypt_and_verify(token)
  rescue ActiveSupport::MessageEncryptor::InvalidMessage
    nil
  end
end