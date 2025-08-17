class Donation < ApplicationRecord
  belongs_to :person
  has_many :items, class_name: 'DonationItem'
  validates :name, presence: true

  # Value is the sum of all the "items" values
  def value
    items.reduce(0){|sum, item| sum += (item.value || 0)}
  end

  def items_attributes=(attrs)
    _items = []
    attrs.each do |item_hash|
      item = item_hash[:id].present? ? DonationItem.find(item_hash[:id]) : DonationItem.new
      item.update(item_hash)
      item.errors.each do |err|
        self.errors.add err.attribute, err.message
      end
      _items << item
    end

    self.items = _items
  end
end
