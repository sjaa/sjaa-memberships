class AddPaypalFieldsToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :price, :decimal
    add_column :memberships, :token, :string
    add_column :memberships, :paid, :boolean, default: false
  end
end
