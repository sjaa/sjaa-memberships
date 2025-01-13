class Person < ApplicationRecord
  has_many :memberships, -> {order(start: :asc)}
  has_many :donations
  has_many :equipment
  has_many :contacts
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
    end
    self.astrobin = _astrobin
  end
end
