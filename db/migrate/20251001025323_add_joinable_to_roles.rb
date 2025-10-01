class AddJoinableToRoles < ActiveRecord::Migration[7.1]
  def change
    add_column :roles, :joinable, :boolean, default: false
  end
end
