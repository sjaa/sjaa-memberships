require 'test_helper'

class PeopleSkillTest < ActiveSupport::TestCase
  setup do
    @person = Person.create!(first_name: 'John', last_name: 'Doe', password: 'password123')
    @contact = Contact.create!(email: 'john@example.com', person: @person, primary: true)
    @skill = Skill.create!(name: 'Photography', description: 'Astrophotography skills')
  end

  test 'valid people_skill with valid levels' do
    people_skill = PeopleSkill.new(
      person: @person,
      skill: @skill,
      skill_level: 2
    )
    assert people_skill.valid?
  end

  test 'skill_level must be between 0 and 3' do
    # Rails enum raises ArgumentError for invalid values, so we test with valid values
    people_skill = PeopleSkill.new(person: @person, skill: @skill, skill_level: 0)
    assert people_skill.valid?

    people_skill.skill_level = 3
    assert people_skill.valid?

    # Test that invalid values raise ArgumentError
    assert_raises(ArgumentError) do
      PeopleSkill.new(person: @person, skill: @skill, skill_level: 4)
    end
  end

  test 'skill_level accepts enum values' do
    people_skill = PeopleSkill.new(person: @person, skill: @skill, skill_level: :beginner)
    assert people_skill.valid?
    assert_equal 'beginner', people_skill.skill_level
    assert people_skill.skill_beginner?

    people_skill.skill_level = :advanced
    assert people_skill.valid?
    assert_equal 'advanced', people_skill.skill_level
    assert people_skill.skill_advanced?
  end

  test 'person can only have one record per skill' do
    PeopleSkill.create!(person: @person, skill: @skill, skill_level: 2)

    duplicate = PeopleSkill.new(person: @person, skill: @skill, skill_level: 1)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person_id], "has already been taken"
  end

  test 'active? returns true when skill_level > 0' do
    people_skill = PeopleSkill.create!(person: @person, skill: @skill, skill_level: 2)
    assert people_skill.active?
  end

  test 'active? returns false when skill_level is 0 or none' do
    people_skill = PeopleSkill.create!(person: @person, skill: @skill, skill_level: 0)
    assert_not people_skill.active?

    people_skill.skill_level = :none
    assert_not people_skill.active?
  end

  test 'skill_level_name returns human-readable name' do
    people_skill = PeopleSkill.create!(person: @person, skill: @skill, skill_level: 0)
    assert_equal 'None', people_skill.skill_level_name

    people_skill.skill_level = :beginner
    assert_equal 'Beginner', people_skill.skill_level_name

    people_skill.skill_level = :intermediate
    assert_equal 'Intermediate', people_skill.skill_level_name

    people_skill.skill_level = :advanced
    assert_equal 'Advanced', people_skill.skill_level_name
  end

  test 'person can have multiple skills' do
    skill2 = Skill.create!(name: 'Event Planning', description: 'Planning events')

    PeopleSkill.create!(person: @person, skill: @skill, skill_level: 2)
    PeopleSkill.create!(person: @person, skill: skill2, skill_level: 1)

    assert_equal 2, @person.people_skills.count
    assert_equal 2, @person.skills.count
  end

  test 'skill can have multiple people' do
    person2 = Person.create!(first_name: 'Jane', last_name: 'Smith', password: 'password123')

    PeopleSkill.create!(person: @person, skill: @skill, skill_level: 2)
    PeopleSkill.create!(person: person2, skill: @skill, skill_level: 3)

    assert_equal 2, @skill.people_skills.count
    assert_equal 2, @skill.people.count
  end
end
