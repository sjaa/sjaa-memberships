class State < ApplicationRecord
  validates :name, uniqueness: true
  validates :short_name, uniqueness: true
  has_many :contacts

  def to_combobox_display
    name&.titleize
  end
end
