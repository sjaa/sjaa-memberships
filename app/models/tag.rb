class Tag < ApplicationRecord
  has_and_belongs_to_many :equipment
  before_save :caseitize

  def caseitize
    self.name = self.name.downcase.strip
  end
end
