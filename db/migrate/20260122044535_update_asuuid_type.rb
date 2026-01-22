class UpdateAsuuidType < ActiveRecord::Migration[7.1]
  def up
    # Remove the unique index first
    remove_index :active_storage_attachments, name: "index_active_storage_attachments_uniqueness"
    
    # Change column to string
    change_column :active_storage_attachments, :record_id, :string
    
    # Re-add the index
    add_index :active_storage_attachments, [:record_type, :record_id, :name, :blob_id],
              name: "index_active_storage_attachments_uniqueness", unique: true
  end

  def down
    remove_index :active_storage_attachments, name: "index_active_storage_attachments_uniqueness"
    change_column :active_storage_attachments, :record_id, :bigint, using: 'record_id::bigint'
    add_index :active_storage_attachments, [:record_type, :record_id, :name, :blob_id],
              name: "index_active_storage_attachments_uniqueness", unique: true
  end

end
