class AddAuthorToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :author, :string
  end
end