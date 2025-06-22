class AddSignupCompletedToPerson < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :signup_completed, :boolean, default: true, null: false
  end
end
