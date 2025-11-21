class AddTelescopiusIdToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :telescopius_id, :integer
  end
end
