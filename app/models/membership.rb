class Membership < ApplicationRecord
  belongs_to :person
  belongs_to :order, required: false
  belongs_to :kind, class_name: 'MembershipKind', required: false
  inheritance_column = :inherits

  def end
    return nil if(term_months.nil?)
    start + term_months.months
  end
end
