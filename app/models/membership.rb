class Membership < ApplicationRecord
  belongs_to :person
  belongs_to :order, required: false
  belongs_to :kind, class_name: 'MembershipKind', required: false
  before_save :update_end_date
  inheritance_column = :inherits

  def is_active?
    return true if(self.end.nil?)
    DateTime.now <= (self.end || 0)
  end

  private
  def update_end_date
    if(self.start.present? && self.term_months.present?)
      self.end = (self.start + self.term_months.months).end_of_month
    end
  end
end
