class AddVolunteerFieldsToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :volunteer, :boolean, default: false
    add_column :people, :mentor, :boolean, default: false
  end
end
