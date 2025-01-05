class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.integer :astrobin_id
      t.string :notes
      t.string :discord_id
      t.integer :status_id
      t.integer :referral_id

      t.timestamps
    end
    add_index :people, :first_name
    add_index :people, :last_name
  end
end
