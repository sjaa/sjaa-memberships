class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal  :price
      t.string :token
      t.boolean :paid, default: false
      t.json :membership_params
      t.timestamps
    end

    add_index :orders, :token

    remove_column :memberships, :price, :decimal
    remove_column :memberships, :token, :string
    remove_column :memberships, :paid, :boolean
    remove_column :memberships, :new, :boolean

    add_column :memberships, :order_id, :integer
  end
end
