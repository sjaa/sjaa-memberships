class Donation < ApplicationRecord
  belongs_to :person
  has_many :items, ->{ includes(:equipment) }, class_name: 'DonationItem'

  # Value is the sum of all the "items" values
  def value
    items.reduce(0){|sum, item| sum += (item.value || 0)}
  end
end
