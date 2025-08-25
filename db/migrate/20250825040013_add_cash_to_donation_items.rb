class AddCashToDonationItems < ActiveRecord::Migration[7.1]
  def change
    add_column :donation_items, :cash, :boolean, default: false
  end
end
