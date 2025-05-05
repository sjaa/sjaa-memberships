class MembershipKind < ApplicationRecord
  has_many :memberships, foreign_key: 'kind_id'
  validates :name, uniqueness: true
  before_save { name&.upcase! }

  def to_combobox_display
    name
  end
end
