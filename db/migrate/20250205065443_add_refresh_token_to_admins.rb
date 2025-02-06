class AddRefreshTokenToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :refresh_token, :string
  end
end
