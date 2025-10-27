class DeleteSignupCompletedFromPerson < ActiveRecord::Migration[7.1]
  def change
    remove_column :people, :signup_completed
  end
end
