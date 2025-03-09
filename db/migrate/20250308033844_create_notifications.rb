class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :message
      t.integer :person_id
      t.integer :admin_id
      t.boolean :unread, default: true

      t.timestamps
    end

    add_index :notifications, :unread
  end
end
