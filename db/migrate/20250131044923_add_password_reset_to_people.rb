class AddPasswordResetToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :reset_password_token, :string
    add_column :people, :reset_password_sent_at, :datetime

    add_column :admins, :reset_password_token, :string
    add_column :admins, :reset_password_sent_at, :datetime
  end
end
