class CreateOpportunities < ActiveRecord::Migration[7.1]
  def change
    create_table :opportunities do |t|
      t.string :title, null: false
      t.text :description
      t.string :email

      t.timestamps
    end

    add_index :opportunities, :title
  end
end
