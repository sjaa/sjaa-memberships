class Status < ApplicationRecord
  has_many :people

  def to_combobox_display
    name&.titleize
  end
end
