class Tag < ApplicationRecord
  has_and_belongs_to_many :equipment
  before_save :caseitize
  validates :name, presence: true, uniqueness: true
  validate :color_validation

  def caseitize
    self.name = self.name.downcase.strip
    self.color&.strip!
    self.icon&.downcase!&.strip!
  end

  def color_validation
    if(color && color !~ /#[a-fA-F0-9]{6}/)
      errors.add(:color, 'needs to be a six-digit hexadecimal number, starting with a #.')
    end
  end
end
