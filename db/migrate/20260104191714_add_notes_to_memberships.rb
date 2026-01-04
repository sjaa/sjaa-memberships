class AddNotesToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :notes, :text
  end
end
