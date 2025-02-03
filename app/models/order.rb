class Order < ApplicationRecord
  has_one :membership
  validates :token, presence: true
  validates :price, presence: true
end
