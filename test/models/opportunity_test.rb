require 'test_helper'

class OpportunityTest < ActiveSupport::TestCase
  setup do
    @opportunity = Opportunity.create!(
      title: 'Website Development',
      description: 'Help maintain the SJAA website',
      email: 'webmaster@sjaa.net'
    )
  end

  test 'valid opportunity with required attributes' do
    assert @opportunity.valid?
    assert_equal 'Website Development', @opportunity.title
  end

  test 'opportunity title is required' do
    opportunity = Opportunity.new(description: 'Test')
    assert_not opportunity.valid?
    assert_includes opportunity.errors[:title], "can't be blank"
  end

  test 'opportunity email must be valid format if present' do
    @opportunity.email = 'invalid-email'
    assert_not @opportunity.valid?
    assert_includes @opportunity.errors[:email], "is invalid"
  end

  test 'opportunity email can be blank' do
    @opportunity.email = nil
    assert @opportunity.valid?

    @opportunity.email = ''
    assert @opportunity.valid?
  end

  test 'destroying opportunity removes opportunity_skills associations' do
    skill = Skill.create!(name: 'Ruby on Rails', description: 'Web development with Rails')
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill, skill_level: 2)

    assert_equal 1, OpportunitySkill.where(opportunity: @opportunity).count

    @opportunity.destroy

    assert_equal 0, OpportunitySkill.where(opportunity_id: @opportunity.id).count
  end

  test 'opportunity has many skills through opportunity_skills' do
    skill1 = Skill.create!(name: 'JavaScript', description: 'Frontend development')
    skill2 = Skill.create!(name: 'CSS', description: 'Styling')

    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill2, skill_level: 1)

    assert_equal 2, @opportunity.skills.count
    assert_includes @opportunity.skills, skill1
    assert_includes @opportunity.skills, skill2
  end

  # Test for_person class method
  test 'for_person returns all opportunities with zero matches when person is nil' do
    result = Opportunity.for_person(nil)

    assert_equal 1, result.length
    assert_equal @opportunity, result[0][0]
    assert_equal 0, result[0][1] # full_match_count
    assert_equal 0, result[0][2] # partial_match_count
  end

  test 'for_person returns all opportunities with zero matches when person has no skills' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')

    result = Opportunity.for_person(person)

    assert_equal 1, result.length
    assert_equal @opportunity, result[0][0]
    assert_equal 0, result[0][1] # full_match_count
    assert_equal 0, result[0][2] # partial_match_count
  end

  test 'for_person counts full matches correctly' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    # Person has both skills at high level
    PeopleSkill.create!(person: person, skill: skill1, skill_level: 3)
    PeopleSkill.create!(person: person, skill: skill2, skill_level: 2)

    # Opportunity requires both skills at lower levels
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill2, skill_level: 1)

    result = Opportunity.for_person(person)

    assert_equal 1, result.length
    assert_equal @opportunity, result[0][0]
    assert_equal 2, result[0][1] # full_match_count - person meets both requirements
    assert_equal 0, result[0][2] # partial_match_count
  end

  test 'for_person counts partial matches correctly' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    # Person has both skills but at lower levels than required
    PeopleSkill.create!(person: person, skill: skill1, skill_level: 1)
    PeopleSkill.create!(person: person, skill: skill2, skill_level: 1)

    # Opportunity requires both skills at higher levels
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 3)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill2, skill_level: 2)

    result = Opportunity.for_person(person)

    assert_equal 1, result.length
    assert_equal @opportunity, result[0][0]
    assert_equal 0, result[0][1] # full_match_count
    assert_equal 2, result[0][2] # partial_match_count - person has skills but not high enough
  end

  test 'for_person counts mixed full and partial matches' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    # Person has skill1 at high level, skill2 at low level
    PeopleSkill.create!(person: person, skill: skill1, skill_level: 3)
    PeopleSkill.create!(person: person, skill: skill2, skill_level: 1)

    # Opportunity requires skill1 at lower level, skill2 at higher level
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill2, skill_level: 2)

    result = Opportunity.for_person(person)

    assert_equal 1, result.length
    assert_equal @opportunity, result[0][0]
    assert_equal 1, result[0][1] # full_match_count - skill1 fully matches
    assert_equal 1, result[0][2] # partial_match_count - skill2 partially matches
  end

  test 'for_person sorts by full matches then partial matches' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')

    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')
    skill3 = Skill.create!(name: 'JavaScript', description: 'JS programming')

    PeopleSkill.create!(person: person, skill: skill1, skill_level: 3)
    PeopleSkill.create!(person: person, skill: skill2, skill_level: 2)
    PeopleSkill.create!(person: person, skill: skill3, skill_level: 1)

    # Opportunity 1: 2 full matches
    opp1 = Opportunity.create!(title: 'Perfect Match', description: 'Needs Ruby and Rails')
    OpportunitySkill.create!(opportunity: opp1, skill: skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: opp1, skill: skill2, skill_level: 1)

    # Opportunity 2: 1 full match
    opp2 = Opportunity.create!(title: 'Partial Match', description: 'Needs Ruby')
    OpportunitySkill.create!(opportunity: opp2, skill: skill1, skill_level: 2)

    # Opportunity 3: 1 partial match
    opp3 = Opportunity.create!(title: 'Weak Match', description: 'Needs advanced JS')
    OpportunitySkill.create!(opportunity: opp3, skill: skill3, skill_level: 2)

    result = Opportunity.for_person(person)

    assert_equal 4, result.length
    # Should be sorted: opp1 (2 full), opp2 (1 full), opp3 (1 partial), @opportunity (0)
    assert_equal opp1, result[0][0]
    assert_equal 2, result[0][1]

    assert_equal opp2, result[1][0]
    assert_equal 1, result[1][1]

    assert_equal opp3, result[2][0]
    assert_equal 1, result[2][2]
  end

  # Test matches_person? method
  test 'matches_person? returns false when person is nil' do
    assert_not @opportunity.matches_person?(nil)
  end

  test 'matches_person? returns false when opportunity has no skills' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    assert_not @opportunity.matches_person?(person)
  end

  test 'matches_person? returns true when person meets all requirements' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    PeopleSkill.create!(person: person, skill: skill1, skill_level: 3)
    PeopleSkill.create!(person: person, skill: skill2, skill_level: 2)

    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill2, skill_level: 2)

    assert @opportunity.matches_person?(person)
  end

  test 'matches_person? returns false when person lacks one required skill' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    # Person only has skill1
    PeopleSkill.create!(person: person, skill: skill1, skill_level: 3)

    # Opportunity requires both
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill2, skill_level: 2)

    assert_not @opportunity.matches_person?(person)
  end

  test 'matches_person? returns false when person has skill at too low level' do
    person = Person.create!(first_name: 'Test', last_name: 'User', password: 'password123')
    skill = Skill.create!(name: 'Ruby', description: 'Ruby programming')

    PeopleSkill.create!(person: person, skill: skill, skill_level: 1)
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill, skill_level: 3)

    assert_not @opportunity.matches_person?(person)
  end

  # Test skills_attributes= method
  test 'skills_attributes= creates new opportunity_skills' do
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    @opportunity.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 3 }
    ]
    @opportunity.save!

    assert_equal 2, @opportunity.opportunity_skills.count

    ruby_skill = @opportunity.opportunity_skills.find_by(skill: skill1)
    assert_equal 2, ruby_skill.skill_level_before_type_cast

    rails_skill = @opportunity.opportunity_skills.find_by(skill: skill2)
    assert_equal 3, rails_skill.skill_level_before_type_cast
  end

  test 'skills_attributes= clears existing skills before creating new ones' do
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    # Create initial skills
    OpportunitySkill.create!(opportunity: @opportunity, skill: skill1, skill_level: 2)
    assert_equal 1, @opportunity.opportunity_skills.count

    # Replace with new skills
    @opportunity.skills_attributes = [
      { skill_id: skill2.id, skill_level: 3 }
    ]
    @opportunity.save!

    assert_equal 1, @opportunity.opportunity_skills.count
    assert_nil @opportunity.opportunity_skills.find_by(skill: skill1)
    assert_not_nil @opportunity.opportunity_skills.find_by(skill: skill2)
  end

  test 'skills_attributes= skips blank skill_ids' do
    skill = Skill.create!(name: 'Ruby', description: 'Ruby programming')

    @opportunity.skills_attributes = [
      { skill_id: skill.id, skill_level: 2 },
      { skill_id: '', skill_level: 3 },
      { skill_id: nil, skill_level: 1 }
    ]
    @opportunity.save!

    assert_equal 1, @opportunity.opportunity_skills.count
    assert_equal skill, @opportunity.opportunity_skills.first.skill
  end

  test 'skills_attributes= skips skill_level of 0' do
    skill1 = Skill.create!(name: 'Ruby', description: 'Ruby programming')
    skill2 = Skill.create!(name: 'Rails', description: 'Rails framework')

    @opportunity.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 0 }
    ]
    @opportunity.save!

    assert_equal 1, @opportunity.opportunity_skills.count
    assert_equal skill1, @opportunity.opportunity_skills.first.skill
  end

  test 'skills_attributes= accepts string keys' do
    skill = Skill.create!(name: 'Ruby', description: 'Ruby programming')

    @opportunity.skills_attributes = [
      { 'skill_id' => skill.id.to_s, 'skill_level' => '2' }
    ]
    @opportunity.save!

    assert_equal 1, @opportunity.opportunity_skills.count
    assert_equal 2, @opportunity.opportunity_skills.first.skill_level_before_type_cast
  end
end
