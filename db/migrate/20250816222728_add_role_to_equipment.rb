class AddRoleToEquipment < ActiveRecord::Migration[7.1]
  def change
    add_column :equipment, :role_id, :integer
    add_index :equipment, :role_id
  end
end
