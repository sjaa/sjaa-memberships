class AddDonationAmountToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :donation_amount, :decimal
  end
end
