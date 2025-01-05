class CreateAstrobins < ActiveRecord::Migration[7.1]
  def change
    create_table :astrobins do |t|
      t.string :username
      t.integer :latest_image

      t.timestamps
    end
  end
end
