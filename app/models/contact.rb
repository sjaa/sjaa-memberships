class Contact < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :state, optional: true
  belongs_to :person
  validates :email, uniqueness: true
  before_save { email.downcase! }
end
