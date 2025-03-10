class Interest < ApplicationRecord
  validates :name, uniqueness: true
  has_and_belongs_to_many :people

  def to_combobox_display
    name
  end
end
