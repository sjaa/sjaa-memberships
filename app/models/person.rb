class Person < ApplicationRecord
  has_many :memberships, -> {includes(:kind).order(start: :asc)}
  has_many :donations, -> {includes(:items)}
  has_many :equipment, -> {includes(:instrument)}
  has_many :contacts, -> {includes(:city, :state)}
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :groups
  belongs_to :status, optional: true
  belongs_to :astrobin, optional: true
  belongs_to :referral, optional: true

  def self.lapsed_members(status: nil)
    people_query = Person.all
    people_query = people_query.joins(:status).where(status: {name: status}) if(status)
    result = people_query.select do |person|
      latest_membership = person.memberships.order(start: :desc).first
      if(latest_membership.term_months.nil?)
        true
      elsif(latest_membership.start.nil?)
        false
      else
        (latest_membership.start + latest_membership.term_months.months) < DateTime.now
      end
    end

    return result
  end

  def name
    return "#{first_name} #{last_name}"
  end

  # Assumes a 12-month term
  def active_membership(date: DateTime.now())
    memberships.where(Membership.arel_table[:start].gt(DateTime.now - 12.months))
  end

  # Take an array of the form [{id: 4}, {name: 'foo'}, ...]
  # and find/create/delete
  def interests_attributes=(attributes)
    _interests = []
    attributes.each do |attribute|
      _attribute = attribute.dup

      # Don't try to save blank names
      next if(attribute[:name].blank? && attribute[:id].blank?)
      # If we see any name, ignore the id
      _attribute.delete(:id) if(!attribute[:name].blank?)
      _attribute[:name]&.downcase!
      _interests << Interest.find_or_create_by(_attribute)
    end

    self.interests = _interests
  end

  def astrobin_attributes=(attributes)
    _astrobin = nil
    if(attributes[:id].blank?)
      _astrobin = Astrobin.new(attributes)
    else
      _astrobin = Astrobin.find(attributes[:id])
      _attributes = attributes.dup
      _attributes.delete(:id)
      _astrobin.update(_attributes)
      _astrobin.errors.each do |err|
        self.errors.add err.attribute, err.message
      end
    end
    self.astrobin = _astrobin
  end

  def contact_attributes=(attributes)
    _contacts = []
    attributes.each do |contact_attr|
      contact = contact_attr[:id].present? ? Contact.find(contact_attr[:id]) : Contact.new
      _contact_attr = contact_attr.dup

      # Use strings for true/false so they are easier to display in the forms, but save them as booleans
      _contact_attr[:primary] = _contact_attr[:primary] == "true"
      _contact_attr.delete(:id)

      # If there's a city name, then we need to create  new city
      if(_contact_attr[:city_name].present?)
        city = City.new(name: _contact_attr[:city_name])
        _contact_attr.delete(:city_name)
        _contact_attr.delete(:city_id)
        _contact_attr[:city] = city
      end

      contact.update _contact_attr
      contact.errors.each do |err|
        self.errors.add err.attribute, err.message
      end
      _contacts << contact
    end

    self.contacts = _contacts
  end

  def membership_attributes=(attributes)
    _memberships = []
    attributes.each do |membership_attr|
      membership = membership_attr[:id].present? ? Membership.find(membership_attr[:id]) : Membership.new
      _membership_attr = membership_attr.dup

      # Use strings for true/false so they are easier to display in the forms, but save them as booleans
      _membership_attr[:ephemeris] = _membership_attr[:ephemeris] == "true"
      _membership_attr[:new] = _membership_attr[:new] == "true"
      _membership_attr.delete(:id)

      # If there's a city name, then we need to create  new city
      if(_membership_attr[:kind].present?)
        kind = MembershipKind.new(name: _membership_attr[:kind])
        _membership_attr.delete(:kind)
        _membership_attr.delete(:kind_id)
        _membership_attr[:kind] = kind
      end

      if(_membership_attr[:start])
        _membership_attr[:start] = DateTime.parse _membership_attr[:start]
      end

      membership.update _membership_attr
      membership.errors.each do |err|
        self.errors.add err.attribute, err.message
      end
      _memberships << membership
    end

    self.memberships = _memberships
  end
end
