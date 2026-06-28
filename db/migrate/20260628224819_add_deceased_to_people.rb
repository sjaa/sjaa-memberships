class AddDeceasedToPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :people, :deceased, :boolean, default: false, null: false
  end
end
