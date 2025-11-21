class Telescopius < ApplicationRecord
  validates :username, strip: { downcase: false }
  has_one :person
end
