class Permission < ApplicationRecord
  validates :name, uniqueness: true
  has_and_belongs_to_many :admins
  has_and_belongs_to_many :people
end
