class AddDiscordIdToRoles < ActiveRecord::Migration[7.1]
  def change
    add_column :roles, :discord_id, :string
  end
end
