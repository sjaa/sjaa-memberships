class Equipment < ApplicationRecord
  belongs_to :instrument
  belongs_to :person
end
