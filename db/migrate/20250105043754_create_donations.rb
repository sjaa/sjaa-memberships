class CreateDonations < ActiveRecord::Migration[7.1]
  def change
    create_table :donations do |t|
      t.datetime :date
      t.decimal :value
      t.string :note
      t.integer :person_id

      t.timestamps
    end
    add_index :donations, :person_id
  end
end
