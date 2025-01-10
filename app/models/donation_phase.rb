class DonationPhase < ApplicationRecord
  belongs_to :donation_item
  belongs_to :person
end
