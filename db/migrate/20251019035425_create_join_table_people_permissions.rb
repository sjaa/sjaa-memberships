class CreateJoinTablePeoplePermissions < ActiveRecord::Migration[7.1]
  def change
    create_join_table :people, :permissions do |t|
      t.index [:person_id, :permission_id]
      t.index [:permission_id, :person_id]
    end
  end
end
