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
      skill_level: 5,
      interest_level: 7
    )
    assert people_skill.valid?
  end

  test 'skill_level must be between 0 and 10' do
    people_skill = PeopleSkill.new(person: @person, skill: @skill, skill_level: 11, interest_level: 5)
    assert_not people_skill.valid?
    assert_includes people_skill.errors[:skill_level], "must be less than or equal to 10"

    people_skill.skill_level = -1
    assert_not people_skill.valid?
    assert_includes people_skill.errors[:skill_level], "must be greater than or equal to 0"
  end

  test 'interest_level must be between 0 and 10' do
    people_skill = PeopleSkill.new(person: @person, skill: @skill, skill_level: 5, interest_level: 11)
    assert_not people_skill.valid?
    assert_includes people_skill.errors[:interest_level], "must be less than or equal to 10"

    people_skill.interest_level = -1
    assert_not people_skill.valid?
    assert_includes people_skill.errors[:interest_level], "must be greater than or equal to 0"
  end

  test 'person can only have one record per skill' do
    PeopleSkill.create!(person: @person, skill: @skill, skill_level: 5, interest_level: 5)

    duplicate = PeopleSkill.new(person: @person, skill: @skill, skill_level: 3, interest_level: 3)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person_id], "has already been taken"
  end

  test 'active? returns true when skill_level > 0' do
    people_skill = PeopleSkill.create!(person: @person, skill: @skill, skill_level: 5, interest_level: 0)
    assert people_skill.active?
  end

  test 'active? returns true when interest_level > 0' do
    people_skill = PeopleSkill.create!(person: @person, skill: @skill, skill_level: 0, interest_level: 5)
    assert people_skill.active?
  end

  test 'active? returns false when both levels are 0' do
    people_skill = PeopleSkill.create!(person: @person, skill: @skill, skill_level: 0, interest_level: 0)
    assert_not people_skill.active?
  end

  test 'person can have multiple skills' do
    skill2 = Skill.create!(name: 'Event Planning', description: 'Planning events')

    PeopleSkill.create!(person: @person, skill: @skill, skill_level: 5, interest_level: 5)
    PeopleSkill.create!(person: @person, skill: skill2, skill_level: 3, interest_level: 7)

    assert_equal 2, @person.people_skills.count
    assert_equal 2, @person.skills.count
  end

  test 'skill can have multiple people' do
    person2 = Person.create!(first_name: 'Jane', last_name: 'Smith', password: 'password123')

    PeopleSkill.create!(person: @person, skill: @skill, skill_level: 5, interest_level: 5)
    PeopleSkill.create!(person: person2, skill: @skill, skill_level: 3, interest_level: 7)

    assert_equal 2, @skill.people_skills.count
    assert_equal 2, @skill.people.count
  end
end
