class ReconfigureDonations < ActiveRecord::Migration[7.1]
  def change
    remove_column :donations, :value, :decimal
    remove_column :donations, :date, :datetime
    add_column :donations, :name, :string
    add_column :equipment, :note, :string

    create_table :donation_items do |t|
      t.integer :donation_id
      t.integer :equipment_id
      t.decimal :value
      t.timestamps
    end

    add_index :donation_items, :donation_id
    add_index :donation_items, :equipment_id

    create_table :donation_phases do |t|
      t.string :name
      t.integer :donation_item_id
      t.integer :person_id
      t.datetime :date
    end

    add_index :donation_phases, :donation_item_id
    add_index :donation_phases, :person_id
    add_index :donation_phases, :name
  end
end
