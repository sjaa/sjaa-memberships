class Instrument < ApplicationRecord
  has_many :equipment
  before_save :caseitize

  private
  def caseitize
    self.kind = self.kind&.downcase
    self.model = self.model&.upcase
  end
end
