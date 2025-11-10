require "test_helper"

class FilterableTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123"
    )
    @read_permission = Permission.find_or_create_by(name: 'read')
    @admin.permissions << @read_permission

    # Create test people
    @person1 = Person.create!(first_name: "Alice", last_name: "Smith", password: "password123")
    @person2 = Person.create!(first_name: "Bob", last_name: "Jones", password: "password123")
    @person3 = Person.create!(first_name: "Charlie", last_name: "Brown", password: "password123")
    @person4 = Person.create!(first_name: "Diana", last_name: "Williams", password: "password123")

    # Create contacts
    Contact.create!(email: "alice@example.com", person: @person1, primary: true)
    Contact.create!(email: "bob@example.com", person: @person2, primary: true)
    Contact.create!(email: "charlie@example.com", person: @person3, primary: true)
    Contact.create!(email: "diana@example.com", person: @person4, primary: true)

    # Create skills
    @skill_photography = Skill.create!(name: 'Photography', description: 'Astrophotography')
    @skill_event_planning = Skill.create!(name: 'Event Planning', description: 'Organizing events')
    @skill_teaching = Skill.create!(name: 'Teaching', description: 'Education')

    # Assign skills to people
    # person1 has photography and teaching
    @person1.people_skills.create!(skill: @skill_photography, skill_level: 2)
    @person1.people_skills.create!(skill: @skill_teaching, skill_level: 1)

    # person2 has photography only
    @person2.people_skills.create!(skill: @skill_photography, skill_level: 3)

    # person3 has teaching and event planning
    @person3.people_skills.create!(skill: @skill_teaching, skill_level: 2)
    @person3.people_skills.create!(skill: @skill_event_planning, skill_level: 2)

    # person4 has event planning only
    @person4.people_skills.create!(skill: @skill_event_planning, skill_level: 3)
  end

  # Skills filtering tests

  test "filter people by single skill" do
    login_as_admin(@admin)
    post people_search_path, params: { skills: [@skill_photography.id] }

    assert_response :success
    # Should return person1 and person2 (both have photography)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by multiple skills with OR operation" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id, @skill_teaching.id],
      skill_operation: 'or'
    }

    assert_response :success
    # Should return person1, person2, and person3 (anyone with photography OR teaching)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by multiple skills with AND operation" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id, @skill_teaching.id],
      skill_operation: 'and'
    }

    assert_response :success
    # Should return only person1 (has both photography AND teaching)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by three skills with AND operation" do
    # Add photography to person3 so they have all three skills
    @person3.people_skills.create!(skill: @skill_photography, skill_level: 2)

    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id, @skill_teaching.id, @skill_event_planning.id],
      skill_operation: 'and'
    }

    assert_response :success
    # Should return only person3 (has all three skills)
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by three skills with OR operation" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id, @skill_teaching.id, @skill_event_planning.id],
      skill_operation: 'or'
    }

    assert_response :success
    # Should return all four people (everyone has at least one of these skills)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  test "filter with no matching skills returns no results" do
    # Create a skill that no one has
    unused_skill = Skill.create!(name: 'Unused Skill', description: 'Nobody has this')

    login_as_admin(@admin)
    post people_search_path, params: { skills: [unused_skill.id] }

    assert_response :success
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter with empty skills array returns all people" do
    login_as_admin(@admin)
    post people_search_path, params: { skills: [] }

    assert_response :success
    # Should return all people when no skill filter is applied
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  test "filter skills combined with other filters" do
    # Add interest to person1
    interest = Interest.create!(name: 'Observing')
    @person1.interests << interest

    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id],
      interests: [interest.id]
    }

    assert_response :success
    # Should return only person1 (has photography AND the interest)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
  end

  test "filter skills combined with name search" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id],
      first_name: 'Alice'
    }

    assert_response :success
    # Should return only person1 (has photography AND first name matches)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
  end

  test "skills parameter is properly sanitized" do
    login_as_admin(@admin)
    # Try to pass malicious input
    post people_search_path, params: {
      skills: [@skill_photography.id, "'; DROP TABLE skills; --"]
    }

    assert_response :success
    # Should not crash and should filter by valid skill ID only
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
  end

  test "skill_operation defaults to OR when not specified" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_photography.id, @skill_teaching.id]
      # No skill_operation parameter
    }

    assert_response :success
    # Should behave as OR (default)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
  end

  # Test the and_or_helper method behavior

  test "AND operation requires all selected skills" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_teaching.id, @skill_event_planning.id],
      skill_operation: 'and'
    }

    assert_response :success
    # Only person3 has both teaching AND event planning
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "OR operation returns people with any selected skill" do
    login_as_admin(@admin)
    post people_search_path, params: {
      skills: [@skill_teaching.id, @skill_event_planning.id],
      skill_operation: 'or'
    }

    assert_response :success
    # person1, person3, and person4 have at least one of these skills
    response_body = @response.body
    assert_includes response_body, "Alice"  # has teaching
    assert_not_includes response_body, "Bob"  # has neither
    assert_includes response_body, "Charlie"  # has both
    assert_includes response_body, "Diana"  # has event planning
  end

  # Volunteer filtering tests

  test "filter people by volunteer yes" do
    # Set person1 and person3 as volunteers
    @person1.update!(volunteer: true)
    @person3.update!(volunteer: true)

    login_as_admin(@admin)
    post people_search_path, params: { volunteer: 'yes' }

    assert_response :success
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by volunteer no" do
    # Set person1 and person3 as volunteers
    @person1.update!(volunteer: true)
    @person3.update!(volunteer: true)

    login_as_admin(@admin)
    post people_search_path, params: { volunteer: 'no' }

    assert_response :success
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  test "filter people by volunteer either returns all" do
    @person1.update!(volunteer: true)

    login_as_admin(@admin)
    post people_search_path, params: { volunteer: 'either' }

    assert_response :success
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  test "filter people by volunteer with no parameter returns all" do
    @person1.update!(volunteer: true)

    login_as_admin(@admin)
    post people_search_path, params: {}

    assert_response :success
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  # Mentor filtering tests

  test "filter people by mentor yes" do
    # Set person2 and person4 as mentors
    @person2.update!(mentor: true)
    @person4.update!(mentor: true)

    login_as_admin(@admin)
    post people_search_path, params: { mentor: 'yes' }

    assert_response :success
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  test "filter people by mentor no" do
    # Set person2 and person4 as mentors
    @person2.update!(mentor: true)
    @person4.update!(mentor: true)

    login_as_admin(@admin)
    post people_search_path, params: { mentor: 'no' }

    assert_response :success
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by mentor either returns all" do
    @person2.update!(mentor: true)

    login_as_admin(@admin)
    post people_search_path, params: { mentor: 'either' }

    assert_response :success
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_includes response_body, "Charlie"
    assert_includes response_body, "Diana"
  end

  # Combined volunteer and mentor tests

  test "filter people by both volunteer and mentor yes" do
    # Set person1 as both volunteer and mentor
    @person1.update!(volunteer: true, mentor: true)
    # Set person2 as volunteer only
    @person2.update!(volunteer: true, mentor: false)
    # Set person3 as mentor only
    @person3.update!(volunteer: false, mentor: true)

    login_as_admin(@admin)
    post people_search_path, params: { volunteer: 'yes', mentor: 'yes' }

    assert_response :success
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter people by volunteer yes and mentor no" do
    @person1.update!(volunteer: true, mentor: true)
    @person2.update!(volunteer: true, mentor: false)
    @person3.update!(volunteer: false, mentor: true)

    login_as_admin(@admin)
    post people_search_path, params: { volunteer: 'yes', mentor: 'no' }

    assert_response :success
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  test "filter volunteer combined with skills" do
    @person1.update!(volunteer: true)
    @person2.update!(volunteer: true)

    login_as_admin(@admin)
    post people_search_path, params: {
      volunteer: 'yes',
      skills: [@skill_photography.id]
    }

    assert_response :success
    # Should return only people who are volunteers AND have photography skill
    response_body = @response.body
    assert_includes response_body, "Alice"  # volunteer + photography
    assert_includes response_body, "Bob"    # volunteer + photography
    assert_not_includes response_body, "Charlie"  # not volunteer
    assert_not_includes response_body, "Diana"  # not volunteer
  end

  test "filter mentor combined with skills and volunteer" do
    @person1.update!(volunteer: true, mentor: true)
    @person3.update!(volunteer: true, mentor: false)

    login_as_admin(@admin)
    post people_search_path, params: {
      volunteer: 'yes',
      mentor: 'yes',
      skills: [@skill_teaching.id]
    }

    assert_response :success
    # Should return only person1 (volunteer + mentor + teaching skill)
    response_body = @response.body
    assert_includes response_body, "Alice"
    assert_not_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"  # volunteer + teaching, but not mentor
    assert_not_includes response_body, "Diana"
  end

  test "filter mentor combined with name search" do
    @person2.update!(mentor: true)
    @person4.update!(mentor: true)

    login_as_admin(@admin)
    post people_search_path, params: {
      mentor: 'yes',
      first_name: 'Bob'
    }

    assert_response :success
    response_body = @response.body
    assert_not_includes response_body, "Alice"
    assert_includes response_body, "Bob"
    assert_not_includes response_body, "Charlie"
    assert_not_includes response_body, "Diana"
  end

  private

  def login_as_admin(admin)
    post sessions_path, params: { email: admin.email, password: 'password123' }
  end
end
