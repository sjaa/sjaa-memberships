class AddVerifyMembersPermission < ActiveRecord::Migration[7.1]
  def change
    Permission.find_or_create_by(name: 'verify_members')
  end
end
