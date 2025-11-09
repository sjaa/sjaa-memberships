require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123"
    )

    @read_permission = Permission.find_or_create_by(name: 'read')
    @verify_permission = Permission.find_or_create_by(name: 'verify_members')
    @admin.permissions << @read_permission

    @person_with_read = Person.create!(
      first_name: "Read",
      last_name: "User",
      password: "password123"
    )
    @person_with_read.permissions << @read_permission
    Contact.create!(
      email: "read@example.com",
      person: @person_with_read,
      primary: true
    )

    @person_with_verify = Person.create!(
      first_name: "Verify",
      last_name: "User",
      password: "password123"
    )
    @person_with_verify.permissions << @verify_permission
    Contact.create!(
      email: "verify@example.com",
      person: @person_with_verify,
      primary: true
    )

    @regular_person = Person.create!(
      first_name: "Regular",
      last_name: "User",
      password: "password123"
    )
    Contact.create!(
      email: "regular@example.com",
      person: @regular_person,
      primary: true
    )

    @member = Person.create!(
      first_name: "Test",
      last_name: "Member",
      password: "password123"
    )

    @contact = Contact.create!(
      email: "member@example.com",
      person: @member,
      primary: true
    )

    @active_membership = Membership.create!(
      person: @member,
      start: 1.month.ago,
      term_months: 12,
      ephemeris: false
    )

    @expired_member = Person.create!(
      first_name: "Expired",
      last_name: "Member",
      password: "password123"
    )

    @expired_contact = Contact.create!(
      email: "expired@example.com",
      person: @expired_member,
      primary: true
    )

    @expired_membership = Membership.create!(
      person: @expired_member,
      start: 2.years.ago,
      term_months: 12,
      ephemeris: false
    )
  end

  # Test access to verification form
  test "verify_form requires authentication" do
    get verify_membership_form_path
    assert_redirected_to login_path
  end

  test "verify_form allows access with read permission" do
    login_as_admin(@admin)
    get verify_membership_form_path
    assert_response :success
    assert_select 'h1', text: 'Membership Verification'
  end

  test "verify_form allows access with verify_members permission" do
    login_as_person(@person_with_verify)
    get verify_membership_form_path
    assert_response :success
    assert_select 'h1', text: 'Membership Verification'
  end

  test "verify_form redirects person without permissions to edit page" do
    login_as_person(@regular_person)
    get verify_membership_form_path
    assert_redirected_to edit_person_path(@regular_person)
  end

  # Test verification functionality
  test "verify with valid active member" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
    assert_select '.text-success'
    assert_select 'small', text: /Verified on/
  end

  test "verify with expired member" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "expired@example.com" }

    assert_response :success
    assert_select '.card-title', text: /Membership Expired/
    assert_select '.text-danger'
    assert_select 'small', text: /Verified on/
  end

  test "verify with non-existent email" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "nonexistent@example.com" }

    assert_response :success
    assert_select '.card-title', text: /No member found/
    assert_select '.text-danger'
    assert_select 'small', text: /Verified on/
  end

  test "verify with blank email shows validation error" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "" }

    assert_response :unprocessable_entity
    assert_select '.alert-danger', text: /Email address is required/
    assert_select 'small', text: /Attempted on/
  end

  test "verify with whitespace-only email shows validation error" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "   " }

    assert_response :unprocessable_entity
    assert_select '.alert-danger', text: /Email address is required/
  end

  test "verify handles case-insensitive email lookup" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "MEMBER@EXAMPLE.COM" }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
  end

  test "verify trims whitespace from email" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "  member@example.com  " }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
  end

  test "verify works with person having verify_members permission" do
    login_as_person(@person_with_verify)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_response :success
    assert_select '.card-title', text: /Valid Member/
  end

  test "verify redirects person without permissions to edit page" do
    login_as_person(@regular_person)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_redirected_to edit_person_path(@regular_person)
  end

  test "verify includes timestamp in response" do
    login_as_admin(@admin)

    freeze_time do
      post verify_membership_path, params: { email: "member@example.com" }
      expected_timestamp = Time.current.strftime("%B %d, %Y at %I:%M %p")
      assert_select 'small', text: /Verified on #{Regexp.escape(expected_timestamp)}/
    end
  end

  test "verify shows expiration date for valid membership" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "member@example.com" }

    assert_response :success
    expected_expiration = @active_membership.end.strftime("%B %Y")
    assert_select 'p', text: /Membership expires: #{Regexp.escape(expected_expiration)}/
  end

  test "verify shows expiration date for expired membership" do
    login_as_admin(@admin)
    post verify_membership_path, params: { email: "expired@example.com" }

    assert_response :success
    expected_expiration = @expired_membership.end.strftime("%B %Y")
    assert_select 'p', text: /Expired: #{Regexp.escape(expected_expiration)}/
  end

  # Skills update tests
  test "update person with volunteer and mentor flags" do
    login_as_person(@member)

    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        volunteer: true,
        mentor: true
      }
    }

    @member.reload
    assert @member.volunteer
    assert @member.mentor
  end

  test "update person with skills via skills_attributes" do
    login_as_person(@member)

    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')

    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        skills_attributes: [
          { skill_id: skill1.id, skill_level: 5, interest_level: 7 },
          { skill_id: skill2.id, skill_level: 3, interest_level: 8 }
        ]
      }
    }

    @member.reload
    assert_equal 2, @member.skills.count
    assert_includes @member.skills, skill1
    assert_includes @member.skills, skill2

    ps1 = @member.people_skills.find_by(skill: skill1)
    assert_equal 5, ps1.skill_level
    assert_equal 7, ps1.interest_level

    ps2 = @member.people_skills.find_by(skill: skill2)
    assert_equal 3, ps2.skill_level
    assert_equal 8, ps2.interest_level
  end

  test "update person skills from form with all skills" do
    login_as_person(@member)

    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')
    skill3 = Skill.create!(name: 'Teaching', description: 'Education')

    # Simulate form submission where all skills are present, some with 0 values
    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        skills_attributes: [
          { skill_id: skill1.id, skill_level: 5, interest_level: 7 },
          { skill_id: skill2.id, skill_level: 0, interest_level: 0 },
          { skill_id: skill3.id, skill_level: 0, interest_level: 8 }
        ]
      }
    }

    @member.reload
    # Should only have skill1 (both > 0) and skill3 (interest > 0)
    assert_equal 2, @member.skills.count
    assert_includes @member.skills, skill1
    assert_not_includes @member.skills, skill2
    assert_includes @member.skills, skill3
  end

  test "update person removes previous skills not in new submission" do
    login_as_person(@member)

    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')
    skill3 = Skill.create!(name: 'Teaching', description: 'Education')

    # First, add all three skills
    @member.skills_attributes = [
      { skill_id: skill1.id, skill_level: 5, interest_level: 5 },
      { skill_id: skill2.id, skill_level: 3, interest_level: 7 },
      { skill_id: skill3.id, skill_level: 4, interest_level: 6 }
    ]
    @member.save!
    assert_equal 3, @member.skills.count

    # Now update to only include skill1 and skill3
    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        skills_attributes: [
          { skill_id: skill1.id, skill_level: 6, interest_level: 8 },
          { skill_id: skill2.id, skill_level: 0, interest_level: 0 },
          { skill_id: skill3.id, skill_level: 5, interest_level: 7 }
        ]
      }
    }

    @member.reload
    assert_equal 2, @member.skills.count
    assert_includes @member.skills, skill1
    assert_not_includes @member.skills, skill2
    assert_includes @member.skills, skill3
  end

  test "update person skills with string values from form" do
    login_as_person(@member)

    skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    # Form submissions send strings, not integers
    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        skills_attributes: [
          { skill_id: skill.id.to_s, skill_level: '5', interest_level: '7' }
        ]
      }
    }

    @member.reload
    ps = @member.people_skills.first
    assert_equal 5, ps.skill_level
    assert_equal 7, ps.interest_level
  end

  test "update person with combined volunteer flags and skills" do
    login_as_person(@member)

    skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        volunteer: '1',
        mentor: '1',
        skills_attributes: [
          { skill_id: skill.id, skill_level: 8, interest_level: 9 }
        ]
      }
    }

    @member.reload
    assert @member.volunteer
    assert @member.mentor
    assert_equal 1, @member.skills.count

    ps = @member.people_skills.first
    assert_equal 8, ps.skill_level
    assert_equal 9, ps.interest_level
  end

  private

  def login_as_admin(admin)
    post sessions_path, params: { email: admin.email, password: 'password123' }
  end

  def login_as_person(person)
    post sessions_path, params: { email: person.primary_contact.email, password: 'password123' }
  end
end