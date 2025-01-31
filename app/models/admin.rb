class Admin < ApplicationRecord
  include PasswordResettable

  has_secure_password
  has_many :api_keys, as: :bearer
  has_and_belongs_to_many :permissions

  def has_permission?(p)
    self.permissions.where(name: p).first
  end
end
