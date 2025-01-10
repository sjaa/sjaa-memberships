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
end
