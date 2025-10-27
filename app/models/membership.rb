class Membership < ApplicationRecord
  belongs_to :person
  belongs_to :order, required: false
  belongs_to :kind, class_name: 'MembershipKind', required: false
  before_save :update_end_date
  after_commit :add_to_members_group, on: [:create]
  inheritance_column = :inherits

  def is_active?
    return true if(self.end.nil?)
    DateTime.now <= (self.end || 0)
  end

  def term_years
    return nil if(self.term_months.nil?)
    self.term_months / 12
  end

  def update_end_date
    if(self.start.present? && self.term_months.present?)
      self.end = (self.start + self.term_months.months).end_of_month
    end
  end

  def cost
    (term_years.to_f * SjaaMembers::YEARLY_MEMBERSHIP_RATE).to_f + (ephemeris ? SjaaMembers::EPHEMERIS_FEE.to_f : 0.0)
  end

  def total
    cost + donation_amount.to_f
  end

  def self.lifetime
    where(end: nil)
  end

  def self.not_lifetime
    where.not(end: nil)
  end

  def order_attributes=(attributes)
    return if attributes[:payment_method] == 'none' || attributes[:payment_method].blank?

    _order = self.order || Order.new
    _attributes = attributes.dup
    _attributes.delete(:id)

    # Generate a unique token if creating a new order
    if _order.new_record?
      _attributes[:token] = SecureRandom.hex(16)
      _attributes[:price] = self.total
    end

    _order.update(_attributes)
    _order.errors.each do |err|
      self.errors.add err.attribute, err.message
    end

    self.order = _order
  end

  private

  def add_to_members_group
    # Only add to group if this is a new membership that makes the person active
    # Find an admin with Google credentials to use for the API call
    admin_email = Admin.where.not(refresh_token: nil).first&.email

    if admin_email.present? && person.present?
      AddMemberToGroupJob.perform_later(person.id, admin_email)
    else
      Rails.logger.warn "[Membership] Could not queue AddMemberToGroupJob - admin_email: #{admin_email}, person_id: #{person&.id}"
    end
  end
end
