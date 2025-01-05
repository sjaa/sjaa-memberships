class CreateJoinTablePeopleGroups < ActiveRecord::Migration[7.1]
  def change
    create_join_table :people, :groups do |t|
      t.index [:person_id, :group_id]
      t.index [:group_id, :person_id]
    end
  end
end
