class Donation < ApplicationRecord
  belongs_to :person, required: false
  has_many :items, class_name: 'DonationItem', dependent: :destroy
  #validates :name, presence: true

  # Value is the sum of all the "items" values
  def value
    items.reduce(0){|sum, item| sum += (item.value || 0)}
  end

  # Find or create person by email and name
  def person_attributes=(person_attr)
    if(person_attr[:email].present?)
      email = person_attr[:email].strip
      _person = Person.find_by_email(email)
      _person = Person.create(first_name: person_attr[:first_name], last_name: person_attr[:last_name], contact_attributes: [{email: email}]) if(_person.nil?)
      _person.errors.each do |err|
        self.errors.add err.attribute, err.message
      end

      self.person = _person
    end
  end

  def cash=(fields)
    _fields = fields.dup
    value = _fields[:value]&.strip&.to_f || 0
    _id = _fields.delete(:id)
    item = _id.present? ? DonationItem.find(_id) : DonationItem.new
    if(_id.present? || value > 0)
      item.update(fields)
      item.errors.each do |err|
        self.errors.add err.attribute, err.message
      end
      
      self.items << item
    end
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
