class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.integer :instrument_id
      t.string :model
      t.integer :person_id

      t.timestamps
    end
    add_index :equipment, :instrument_id
    add_index :equipment, :person_id
  end
end
