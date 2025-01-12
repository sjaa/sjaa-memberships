class Interest < ApplicationRecord
  has_and_belongs_to_many :people

  def to_combobox_display
    name
  end
end
