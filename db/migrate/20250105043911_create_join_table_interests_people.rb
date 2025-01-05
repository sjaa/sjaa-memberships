class CreateJoinTableInterestsPeople < ActiveRecord::Migration[7.1]
  def change
    create_join_table :interests, :people do |t|
      t.index [:interest_id, :person_id]
      t.index [:person_id, :interest_id]
    end
  end
end
