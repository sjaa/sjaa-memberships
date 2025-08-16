class Instrument < ApplicationRecord
  has_many :equipment
  before_save :caseitize

  private
  include ItemCasable
end
