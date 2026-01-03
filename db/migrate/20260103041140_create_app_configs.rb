class CreateAppConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :app_configs do |t|
      t.string :key, null: false
      t.text :value
      t.string :category, null: false
      t.text :description
      t.boolean :encrypted, default: false, null: false

      t.timestamps
    end
    add_index :app_configs, :key, unique: true
    add_index :app_configs, :category
  end
end
