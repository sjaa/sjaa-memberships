class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|
      t.string :name

      t.timestamps
    end
    add_index :permissions, :name
  end
end
