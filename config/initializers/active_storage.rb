# frozen_string_literal: true

# Add a prefix to all ActiveStorage blob keys for easy identification and retrieval
Rails.application.config.to_prepare do
  ActiveStorage::Blob.class_eval do
    before_create :add_blob_key_prefix

    private

    def add_blob_key_prefix
      self.key = "sjaa-memberships-#{Rails.env}/#{self.class.generate_unique_secure_token}"
    end
  end
end
