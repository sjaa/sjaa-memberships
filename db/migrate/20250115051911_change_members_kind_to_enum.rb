class ChangeMembersKindToEnum < ActiveRecord::Migration[7.1]
  def change
    create_table :membership_kinds do |t|
      t.string :name
      t.timestamps
    end

    remove_column :memberships, :kind, :string
    add_column :memberships, :kind_id, :integer
    add_index :memberships, :kind_id
  end
end
