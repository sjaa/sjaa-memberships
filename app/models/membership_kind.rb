class MembershipKind < ApplicationRecord
  has_many :memberships, foreign_key: 'kind_id'

  def to_combobox_display
    name
  end
end
