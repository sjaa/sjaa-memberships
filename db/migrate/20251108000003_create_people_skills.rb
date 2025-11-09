class CreatePeopleSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :people_skills do |t|
      t.references :person, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.integer :skill_level, default: 0
      t.integer :interest_level, default: 0

      t.timestamps
    end

    add_index :people_skills, [:person_id, :skill_id], unique: true
  end
end
