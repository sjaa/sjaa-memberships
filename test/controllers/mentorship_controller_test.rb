require "test_helper"

class MentorshipControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create an admin to bypass the setup wizard
    Admin.create!(email: 'test@sjaa.net', password: 'password123') if Admin.count == 0

    @referral = Referral.create!(name: 'internet', description: 'Web search')

    # Create an approved mentor
    @approved_mentor = Person.create!(
      first_name: 'Approved',
      last_name: 'Mentor',
      mentor: true,
      mentorship_approval_status: Person::MENTORSHIP_APPROVAL_APPROVED,
      password: 'password123',
      referral: @referral
    )
    Contact.create!(
      email: 'approved@example.com',
      person: @approved_mentor,
      primary: true
    )

    # Create a pending mentor
    @pending_mentor = Person.create!(
      first_name: 'Pending',
      last_name: 'Mentor',
      mentor: true,
      mentorship_approval_status: Person::MENTORSHIP_APPROVAL_PENDING,
      password: 'password123',
      referral: @referral
    )
    Contact.create!(
      email: 'pending@example.com',
      person: @pending_mentor,
      primary: true
    )

    # Create a denied mentor
    @denied_mentor = Person.create!(
      first_name: 'Denied',
      last_name: 'Mentor',
      mentor: true,
      mentorship_approval_status: Person::MENTORSHIP_APPROVAL_DENIED,
      password: 'password123',
      referral: @referral
    )
    Contact.create!(
      email: 'denied@example.com',
      person: @denied_mentor,
      primary: true
    )

    # Create a mentor with no approval status
    @unapproved_mentor = Person.create!(
      first_name: 'Unapproved',
      last_name: 'Mentor',
      mentor: true,
      mentorship_approval_status: nil,
      password: 'password123',
      referral: @referral
    )
    Contact.create!(
      email: 'unapproved@example.com',
      person: @unapproved_mentor,
      primary: true
    )

    # Create a non-mentor
    @non_mentor = Person.create!(
      first_name: 'Not',
      last_name: 'Mentor',
      mentor: false,
      password: 'password123',
      referral: @referral
    )
    Contact.create!(
      email: 'notmentor@example.com',
      person: @non_mentor,
      primary: true
    )
  end

  test "mentorship index page loads successfully" do
    login_as_person(@approved_mentor)
    get mentorship_path
    assert_response :success
  end

  test "mentorship index only shows approved mentors" do
    login_as_person(@approved_mentor)
    get mentorship_path
    assert_response :success

    # Check that approved mentor appears
    assert_select 'body', text: /Approved/

    # Check that pending mentor does not appear
    assert_select 'body', { text: /Pending/, count: 0 }

    # Check that denied mentor does not appear
    assert_select 'body', { text: /Denied/, count: 0 }

    # Check that unapproved mentor does not appear
    assert_select 'body', { text: /Unapproved/, count: 0 }

    # Check that non-mentor does not appear
    assert_select 'body', { text: /Not Mentor/, count: 0 }
  end

  test "mentorship search only returns approved mentors" do
    login_as_person(@approved_mentor)
    post mentorship_search_path
    assert_response :success

    # Verify that response body contains only approved mentor
    assert_match /Approved/, response.body
    assert_no_match /Pending/, response.body
    assert_no_match /Denied/, response.body
   assert_no_match /Unapproved/, response.body
  end

  test "mentorship search filters correctly with skills" do
    login_as_person(@approved_mentor)
    # Create skills
    photography = Skill.create!(name: 'Photography', description: 'Astrophotography')
    teaching = Skill.create!(name: 'Teaching', description: 'Education')

    # Give approved mentor photography skill
    @approved_mentor.skills_attributes = [
      { skill_id: photography.id, skill_level: 2 }
    ]
    @approved_mentor.save!

    # Create another approved mentor with different skills
    other_mentor = Person.create!(
      first_name: 'Other',
      last_name: 'Mentor',
      mentor: true,
      mentorship_approval_status: Person::MENTORSHIP_APPROVAL_APPROVED,
      password: 'password123',
      referral: @referral
    )
    other_mentor.skills_attributes = [
      { skill_id: teaching.id, skill_level: 3 }
    ]
    other_mentor.save!

    # Search for photography mentors
    post mentorship_search_path, params: { skills: [photography.id] }
    assert_response :success

    # Should include approved mentor with photography skill
    assert_match /Approved/, response.body
    # Should not include other mentor with teaching skill
    assert_no_match /Other/, response.body
  end

  test "mentorship index excludes mentors who unchecked mentor but are still approved" do
    # Create a person who was approved but then unchecked the mentor box
    unchecked_mentor = Person.create!(
      first_name: 'Unchecked',
      last_name: 'Mentor',
      mentor: false, # Unchecked mentor box
      mentorship_approval_status: Person::MENTORSHIP_APPROVAL_APPROVED, # But still approved
      password: 'password123',
      referral: @referral
    )
    Contact.create!(
      email: 'unchecked@example.com',
      person: unchecked_mentor,
      primary: true
    )

    login_as_person(@approved_mentor)
    get mentorship_path
    assert_response :success

    # Should not appear because mentor flag is false
    assert_no_match /Unchecked/, response.body
  end

  test "mentorship search requires both mentor flag and approved status" do
    login_as_person(@approved_mentor)
    get mentorship_path
    assert_response :success

    # Verify only approved mentor appears
    assert_match /Approved/, response.body

    # Verify other statuses don't appear
    assert_no_match /Pending/, response.body
    assert_no_match /Denied/, response.body
    assert_no_match /Unapproved/, response.body
  end
end
