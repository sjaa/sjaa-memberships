class Order < ApplicationRecord
  has_one :membership
  validates :token, presence: true
  validates :price, presence: true
  validates :payment_method, inclusion: { in: %w[cash check paypal], allow_blank: true }
end
