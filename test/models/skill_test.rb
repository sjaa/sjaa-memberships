require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup do
    @skill = Skill.create!(
      name: 'Event Planning',
      description: 'Planning and organizing SJAA events',
      email: 'skills-event-planning@sjaa.net'
    )
  end

  test 'valid skill with required attributes' do
    assert @skill.valid?
    assert_equal 'Event Planning', @skill.name
  end

  test 'skill name is required' do
    skill = Skill.new(description: 'Test')
    assert_not skill.valid?
    assert_includes skill.errors[:name], "can't be blank"
  end

  test 'skill name must be unique' do
    duplicate_skill = Skill.new(name: 'Event Planning')
    assert_not duplicate_skill.valid?
    assert_includes duplicate_skill.errors[:name], "has already been taken"
  end

  test 'skill email must be valid format if present' do
    @skill.email = 'invalid-email'
    assert_not @skill.valid?
    assert_includes @skill.errors[:email], "is invalid"
  end

  test 'skill email can be blank' do
    @skill.email = nil
    assert @skill.valid?

    @skill.email = ''
    assert @skill.valid?
  end

  test 'skill name is normalized before validation' do
    skill = Skill.create!(name: '  Photography  ')
    assert_equal 'Photography', skill.name
  end

  test 'generate_email creates proper email format' do
    skill = Skill.new(name: 'Telescope Repair')
    assert_equal 'skills-telescope-repair@sjaa.net', skill.generate_email
  end

  test 'generate_email handles special characters' do
    skill = Skill.new(name: 'Web Design & Development')
    assert_equal 'skills-web-design-development@sjaa.net', skill.generate_email
  end

  test 'active_members returns people with skill level > 0' do
    person1 = Person.create!(first_name: 'Alice', last_name: 'Smith', password: 'password123')
    person2 = Person.create!(first_name: 'Bob', last_name: 'Jones', password: 'password123')
    person3 = Person.create!(first_name: 'Charlie', last_name: 'Brown', password: 'password123')

    # Person with skill level
    PeopleSkill.create!(person: person1, skill: @skill, skill_level: 2)

    # Person with different skill level
    PeopleSkill.create!(person: person2, skill: @skill, skill_level: 1)

    # Person with skill level 0 (should not be included)
    PeopleSkill.create!(person: person3, skill: @skill, skill_level: 0)

    active = @skill.active_members
    assert_equal 2, active.count
    assert_includes active, person1
    assert_includes active, person2
    assert_not_includes active, person3
  end

  test 'active_members does not return duplicates for people with multiple skills' do
    person = Person.create!(first_name: 'Homer', last_name: 'Simpson', password: 'password123')
    other_skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    # Give the person both this skill and another skill
    PeopleSkill.create!(person: person, skill: @skill, skill_level: 2)
    PeopleSkill.create!(person: person, skill: other_skill, skill_level: 3)

    active = @skill.active_members
    # Should only appear once despite having multiple skills
    assert_equal 1, active.count
    assert_equal 1, active.to_a.count { |p| p.id == person.id }
  end

  test 'active_sjaa_members filters for active memberships' do
    # Create active member with skill
    active_person = Person.create!(first_name: 'Active', last_name: 'Member', password: 'password123')
    Contact.create!(email: 'active@example.com', person: active_person, primary: true)
    Membership.create!(person: active_person, start: Date.current, term_months: 12)
    PeopleSkill.create!(person: active_person, skill: @skill, skill_level: 2)

    # Create expired member with skill
    expired_person = Person.create!(first_name: 'Expired', last_name: 'Member', password: 'password123')
    Contact.create!(email: 'expired@example.com', person: expired_person, primary: true)
    Membership.create!(person: expired_person, start: 2.years.ago, term_months: 12)
    PeopleSkill.create!(person: expired_person, skill: @skill, skill_level: 2)

    active_sjaa = @skill.active_sjaa_members
    assert_includes active_sjaa, active_person
    assert_not_includes active_sjaa, expired_person
  end

  test 'destroying skill removes people_skills associations' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    PeopleSkill.create!(person: person, skill: @skill, skill_level: 2)

    assert_equal 1, PeopleSkill.where(skill: @skill).count

    @skill.destroy

    assert_equal 0, PeopleSkill.where(skill_id: @skill.id).count
  end
end
