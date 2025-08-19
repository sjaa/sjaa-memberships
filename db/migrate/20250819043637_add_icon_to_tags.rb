class AddIconToTags < ActiveRecord::Migration[7.1]
  def change
    add_column :tags, :icon, :string
  end
end
