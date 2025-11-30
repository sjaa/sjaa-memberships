class AddFieldsToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :category, :string, default: 'system'
    add_column :notifications, :priority, :string, default: 'normal'
    add_column :notifications, :job_id, :string
    add_column :notifications, :job_status, :string
    add_column :notifications, :action_url, :string

    add_index :notifications, :category
    add_index :notifications, :job_id
    add_index :notifications, [:person_id, :unread]
    add_index :notifications, [:admin_id, :unread]
    add_index :notifications, :created_at
  end
end
