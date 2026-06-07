class AddDefaultMembershipToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :default_membership, :boolean, default: false, null: false
  end
end
