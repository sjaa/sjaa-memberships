class Membership < ApplicationRecord
  belongs_to :person
  inheritance_column = :inherits
end
