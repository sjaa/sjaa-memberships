class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.datetime :start
      t.integer :term_months
      t.boolean :ephemeris
      t.boolean :new
      t.string :kind
      t.integer :person_id

      t.timestamps
    end
    add_index :memberships, :person_id
  end
end
