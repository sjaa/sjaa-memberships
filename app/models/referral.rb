class Referral < ApplicationRecord
  has_many :people

  def to_combobox_display
    name
  end
end
