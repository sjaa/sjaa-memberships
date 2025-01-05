class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :short_name
      t.string :email

      t.timestamps
    end
  end
end
