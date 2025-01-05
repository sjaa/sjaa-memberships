class Person < ApplicationRecord
  has_many :memberships
  has_many :donations
  has_many :equipment
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :groups
  belongs_to :status, optional: true
  belongs_to :astrobin, optional: true
  belongs_to :referral, optional: true
end
