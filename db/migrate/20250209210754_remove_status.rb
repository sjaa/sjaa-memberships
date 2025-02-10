class RemoveStatus < ActiveRecord::Migration[7.1]
  def change
    # Move statuses to Roles
    Person.all.includes(:status).each do |person|
      person.roles << Role.find_or_create_by(name: person.status.name) if(person.status.present?)
    end

    # Finally, drop the status
    drop_table :statuses
  end
end
