class Tag < ApplicationRecord
  has_and_belongs_to_many :equipment
  before_save :sanitize
  validates :name, presence: true, uniqueness: true
  validate :color_validation

  def sanitize
    self.name = self.name.downcase.strip
    self.color&.strip!
    self.icon&.downcase!&.strip!
    self.color = '#000000' if(self.color.nil?)
  end

  def color_validation
    if(color && color !~ /#[a-fA-F0-9]{6}/)
      errors.add(:color, 'needs to be a six-digit hexadecimal number, starting with a #.')
    end
  end
end
