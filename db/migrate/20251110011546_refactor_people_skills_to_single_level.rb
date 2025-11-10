class RefactorPeopleSkillsToSingleLevel < ActiveRecord::Migration[7.1]
  def up
    # Convert existing data: use the maximum of skill_level and interest_level
    # Then map to 0-3 scale: 0=None, 1-3=Beginner, 4-6=Intermediate, 7-10=Advanced
    execute <<-SQL
      UPDATE people_skills
      SET skill_level = CASE
        WHEN GREATEST(skill_level, interest_level) = 0 THEN 0
        WHEN GREATEST(skill_level, interest_level) BETWEEN 1 AND 3 THEN 1
        WHEN GREATEST(skill_level, interest_level) BETWEEN 4 AND 6 THEN 2
        ELSE 3
      END
    SQL

    # Remove the interest_level column
    remove_column :people_skills, :interest_level, :integer

    # Update validation constraints on skill_level to be 0-3
    change_column_default :people_skills, :skill_level, from: 0, to: 0
  end

  def down
    # Add interest_level back
    add_column :people_skills, :interest_level, :integer, default: 0

    # Convert skill_level back to 0-10 scale (approximate)
    execute <<-SQL
      UPDATE people_skills
      SET skill_level = CASE skill_level
        WHEN 0 THEN 0
        WHEN 1 THEN 2
        WHEN 2 THEN 5
        WHEN 3 THEN 8
        ELSE 0
      END
    SQL
  end
end
