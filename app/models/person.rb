class Person < ApplicationRecord
  include PasswordResettable

  has_many :memberships, -> {includes(:kind).order(start: :asc)}, dependent: :destroy
  has_many :donations, -> {includes(DonationsController::INCLUDES)}
  has_many :equipment, -> {includes(:instrument)}, dependent: :destroy
  has_many :contacts, -> {includes(:city, :state)}, dependent: :destroy
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :roles
  has_many :api_keys, as: :bearer
  has_secure_password validations: false # Rethink this... maybe just force a random password when not present
  belongs_to :astrobin, optional: true
  belongs_to :referral, optional: true

  def name
    return "#{first_name} #{last_name}"
  end

  def primary_contact
    # Use ruby functions to select out primary contacts to take advantage of any
    # preloading
    contacts.to_a.select{|c| c.primary}.first
  end

  def email
    return primary_contact&.email || contacts.first&.email
  end

  # Right now, normal members have no permissions, but they can access their own records
  # through the policy
  def has_permission?(p)
    false
  end

  def self.find_by_email(email)
    email.nil? ? nil : Contact.find_by(email: email)&.person
  end

  def latest_membership
    # Make a nil end (lifetime membership) come up as the latest result
    memberships.sort_by{|m| m.end || (DateTime.now + 999.years)}.last
  end

  def first_membership
    memberships.sort_by{|m| m.start || (DateTime.now + 999.years)}.first
  end

  def next_membership_start_date
    if(latest_membership&.is_active?)
      return (latest_membership.end + 1.day).beginning_of_month
    end

    return Date.today
  end

  def is_active?
    latest_membership&.is_active?
  end

  def status
    is_active? ? 'Active' : 'Expired'
  end

  # Pick out preloaded memberships that match this person
  def membership_map(_memberships, current = false)
    matches = _memberships[self.id] || []
    if(current)
      now = DateTime.now()
      matches.select{|m| m.term_months == nil || (m.start <= now && m.end >= now)}
    end

    return matches
  end

  def active_membership(date: DateTime.now())
    Person.common_active_membership_query(memberships)
  end

  # Returns an Array.  Can't be chained with other AR calls
  def self.inactive_members
    Person.all - active_members
  end

  def self.common_active_membership_query(record)
    record.where("memberships.end > ?", Date.today).or(record.where(memberships: {term_months: nil}))
  end

  def self.active_members
    common_active_membership_query(joins(:memberships))
  end

  def self.lifetime_members
    return Person.joins(:memberships).where(memberships: {end: nil})
  end

  # Members who are within 3 months of expiration are eligible to receive
  # renewal reminders
  def self.renewable_members
    date_max = Date.today.end_of_month + 2.months # Expiring this month and two months ahead
    date_min = Date.today.beginning_of_month - 3.months # Expired up to 3 months ago

    # Begin the Arel madness
    people = Person.arel_table
    memberships = Membership.arel_table

    ## Get a grouping of (person_id, latest_end_date) records
    latest_dates = Membership.select('person_id, MAX("end") AS latest_end').group(:person_id).arel.as('latest')

    ## Get the actual membership records to go along with said latest_date records
    latest_memberships = memberships.join(latest_dates)
      .on(memberships[:person_id].eq(latest_dates[:person_id]).and(memberships[:end].eq(latest_dates[:latest_end])))
      .project(memberships[Arel.star]).as('latest_membership')

    ## Get the people records to go with the full membership records, and apply the desired date range
    ppl_mem = people.join(latest_memberships)
      .on(people[:id].eq(latest_memberships[:person_id]))
      .project(people[Arel.star])
      .distinct(people[:id])
      .where(latest_memberships[:end].between(date_min..date_max))

    ## Compute lifetime members and subtract them
    lifers = lifetime_members

    # End the madness... returns a plain array, not Active Record or Arel
    ppl = find_by_sql(ppl_mem.to_sql) - lifers.to_a

    # Preload memberships data
    ActiveRecord::Associations::Preloader.new(
      records: ppl, 
      associations: [:memberships, :contacts]
    ).call

    return ppl
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

  # Take an array of the form [{id: 4}, ...]
  # and find/create/delete
  def roles_attributes=(attributes)
    _roles = Role.where(id: attributes.map{|h| h[:id]}).uniq
    self.roles = _roles
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
      _membership_attr.delete(:id)

      # Handle finding or creating the membership kind
      # Fetch the actual MembershipKind object so we can handle LIFETIME memberships
      if(_membership_attr[:kind].present?)
        kind = MembershipKind.find_or_create_by(name: _membership_attr[:kind]&.upcase)
        _membership_attr.delete(:kind)
        _membership_attr.delete(:kind_id)
        _membership_attr[:kind] = kind
      elsif(_membership_attr[:kind_id].present?)
        _membership_attr[:kind] = MembershipKind.find _membership_attr[:kind_id]
        _membership_attr.delete(:kind_id)
      end

      # LIFETIME memberships should have no term
      if(_membership_attr[:kind]&.name == 'LIFETIME')
        _membership_attr[:start] = nil
        _membership_attr[:term_months] = nil
      end

      if(_membership_attr[:start].present?)
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

  # Passwords for people can be blank if they've never signed up
  def password_presence
    true
  end
end
