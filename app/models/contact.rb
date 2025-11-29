class Contact < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :state, optional: true
  belongs_to :person

  # Normalize email before validation: strip whitespace and downcase
  before_validation :normalize_email

  validates :email, presence: true, uniqueness: true

  private

  def normalize_email
    self.email = email&.strip&.downcase
  end
end
