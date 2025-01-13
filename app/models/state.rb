class State < ApplicationRecord
  has_many :contacts

  def to_combobox_display
    name&.titleize
  end
end
