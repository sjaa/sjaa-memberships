class Admin < ApplicationRecord
  include PasswordResettable
  before_save :uniquify_permissions

  has_secure_password
  has_many :api_keys, as: :bearer
  has_and_belongs_to_many :permissions, :uniq => true

  def has_permission?(p)
    self.permissions.where(name: p).first
  end

  def uniquify_permissions
    self.permissions = self.permissions.uniq
  end

  def permission_attributes=(permission_ids)
    self.permissions = Permission.where(id: permission_ids)
  end
end
