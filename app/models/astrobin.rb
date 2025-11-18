class Astrobin < ApplicationRecord
  validates :username, strip: { downcase: true }
  has_one :person
end
