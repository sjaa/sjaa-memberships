class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :address
      t.integer :city_id
      t.integer :state_id
      t.string :zipcode
      t.string :phone
      t.string :email
      t.boolean :primary
      t.integer :person_id

      t.timestamps
    end
    add_index :contacts, :person_id
  end
end
