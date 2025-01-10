class DonationItem < ApplicationRecord
  belongs_to :donation
  belongs_to :equipment
  has_many :phases, ->{order(date: :asc)}, class_name: 'DonationPhase'
end
