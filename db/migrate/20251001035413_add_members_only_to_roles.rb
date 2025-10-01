class AddMembersOnlyToRoles < ActiveRecord::Migration[7.1]
  def change
    add_column :roles, :members_only, :boolean, default: false
  end
end
