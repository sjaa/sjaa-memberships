require "test_helper"
require "minitest/mock"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  include GoogleHelper
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
          { skill_id: skill1.id, skill_level: 2 },
          { skill_id: skill2.id, skill_level: 1 }
        ]
      }
    }

    @member.reload
    assert_equal 2, @member.skills.count
    assert_includes @member.skills, skill1
    assert_includes @member.skills, skill2

    ps1 = @member.people_skills.find_by(skill: skill1)
    assert_equal 'intermediate', ps1.skill_level

    ps2 = @member.people_skills.find_by(skill: skill2)
    assert_equal 'beginner', ps2.skill_level
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
          { skill_id: skill1.id, skill_level: 2 },
          { skill_id: skill2.id, skill_level: 0 },
          { skill_id: skill3.id, skill_level: 0 }
        ]
      }
    }

    @member.reload
    # Should only have skill1 (level > 0)
    assert_equal 1, @member.skills.count
    assert_includes @member.skills, skill1
    assert_not_includes @member.skills, skill2
    assert_not_includes @member.skills, skill3
  end

  test "update person removes previous skills not in new submission" do
    login_as_person(@member)

    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')
    skill3 = Skill.create!(name: 'Teaching', description: 'Education')

    # First, add all three skills
    @member.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 1 },
      { skill_id: skill3.id, skill_level: 2 }
    ]
    @member.save!
    assert_equal 3, @member.skills.count

    # Now update to only include skill1 and skill3
    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        skills_attributes: [
          { skill_id: skill1.id, skill_level: 3 },
          { skill_id: skill2.id, skill_level: 0 },
          { skill_id: skill3.id, skill_level: 2 }
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
          { skill_id: skill.id.to_s, skill_level: '2' }
        ]
      }
    }

    @member.reload
    ps = @member.people_skills.first
    assert_equal 'intermediate', ps.skill_level
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
          { skill_id: skill.id, skill_level: 3 }
        ]
      }
    }

    @member.reload
    assert @member.volunteer
    assert @member.mentor
    assert_equal 1, @member.skills.count

    ps = @member.people_skills.first
    assert_equal 'advanced', ps.skill_level
  end

  # Google Groups sync tests
  test "update does not sync Google Groups when person has no email" do
    person_no_email = Person.create!(
      first_name: "No",
      last_name: "Email",
      password: "password123"
    )
    # Create a contact with an email, but we'll test the case where email returns nil
    # by stubbing the email method
    Contact.create!(person: person_no_email, email: "no-email@example.com", primary: true)
    person_no_email.reload

    # Stub the email method to return nil for this test
    person_no_email.define_singleton_method(:email) { nil }

    login_as_admin(@admin)

    group = Group.create!(name: "Test Group", email: "test@sjaa.net", joinable: true)

    stub_google_api_not_called do
      patch person_path(person_no_email), params: {
        person: {
          first_name: "No",
          last_name: "Email",
          joinable_group_ids: [group.id]
        }
      }
    end

    assert_response :redirect
  end

  test "update does not sync when no admin has Google credentials" do
    @admin.update(refresh_token: nil)
    login_as_person(@member)

    group = Group.create!(name: "Test Group", email: "test@sjaa.net", joinable: true)

    stub_google_api_not_called do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: [group.id]
        }
      }
    end

    assert_response :redirect
  end

  test "update adds person to Google Group when group is added" do
    @admin.update!(refresh_token: "test_refresh_token")
    login_as_person(@member)

    group = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)

    stub_google_api_add_member(@member.email, group.email) do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: [group.id]
        }
      }
    end

    @member.reload
    assert_includes @member.groups, group
    assert_response :redirect
  end

  test "update removes person from Google Group when group is removed" do
    @admin.update!(refresh_token: "test_refresh_token")
    group = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)
    @member.groups << group
    login_as_person(@member)

    stub_google_api_remove_member(@member.email, group.email) do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: []
        }
      }
    end

    @member.reload
    assert_not_includes @member.groups, group
    assert_response :redirect
  end

  test "update skips sync for groups without Google email" do
    @admin.update!(refresh_token: "test_refresh_token")
    login_as_person(@member)

    group_no_email = Group.create!(name: "Local Group", email: nil, joinable: true)

    stub_google_api_not_called do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: [group_no_email.id]
        }
      }
    end

    @member.reload
    assert_includes @member.groups, group_no_email
    assert_response :redirect
  end

  test "update skips sync when groups haven't changed" do
    @admin.update!(refresh_token: "test_refresh_token")
    group = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)
    @member.groups << group
    login_as_person(@member)

    stub_google_api_not_called do
      patch person_path(@member), params: {
        person: {
          first_name: "Updated",
          last_name: @member.last_name,
          joinable_group_ids: [group.id]
        }
      }
    end

    @member.reload
    assert_equal "Updated", @member.first_name
    assert_response :redirect
  end

  test "update adds to multiple Google Groups simultaneously" do
    @admin.update!(refresh_token: "test_refresh_token")
    login_as_person(@member)

    group1 = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)
    group2 = Group.create!(name: "Board", email: "board@sjaa.net", joinable: true)

    stub_google_api_add_multiple(@member.email, [group1.email, group2.email]) do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: [group1.id, group2.id]
        }
      }
    end

    @member.reload
    assert_includes @member.groups, group1
    assert_includes @member.groups, group2
    assert_response :redirect
  end

  test "update removes from multiple Google Groups simultaneously" do
    @admin.update!(refresh_token: "test_refresh_token")
    group1 = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)
    group2 = Group.create!(name: "Board", email: "board@sjaa.net", joinable: true)
    @member.groups << [group1, group2]
    login_as_person(@member)

    stub_google_api_remove_multiple(@member.email, [group1.email, group2.email]) do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: []
        }
      }
    end

    @member.reload
    assert_not_includes @member.groups, group1
    assert_not_includes @member.groups, group2
    assert_response :redirect
  end

  test "update handles mixed add and remove operations" do
    @admin.update!(refresh_token: "test_refresh_token")
    group_old = Group.create!(name: "Old Group", email: "old@sjaa.net", joinable: true)
    group_new = Group.create!(name: "New Group", email: "new@sjaa.net", joinable: true)
    @member.groups << group_old
    login_as_person(@member)

    stub_google_api_add_and_remove(@member.email, [group_new.email], [group_old.email]) do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: [group_new.id]
        }
      }
    end

    @member.reload
    assert_includes @member.groups, group_new
    assert_not_includes @member.groups, group_old
    assert_response :redirect
  end

  test "update handles duplicate member error gracefully" do
    @admin.update!(refresh_token: "test_refresh_token")
    login_as_person(@member)

    group = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)

    stub_google_api_duplicate_error do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: [group.id]
        }
      }
    end

    @member.reload
    assert_includes @member.groups, group
    assert_response :redirect
  end

  test "update handles member not found error gracefully" do
    @admin.update!(refresh_token: "test_refresh_token")
    group = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)
    @member.groups << group
    login_as_person(@member)

    stub_google_api_not_found_error do
      patch person_path(@member), params: {
        person: {
          first_name: @member.first_name,
          last_name: @member.last_name,
          joinable_group_ids: []
        }
      }
    end

    @member.reload
    assert_not_includes @member.groups, group
    assert_response :redirect
  end

  test "update succeeds even when Google API fails" do
    @admin.update!(refresh_token: "test_refresh_token")
    login_as_person(@member)

    group = Group.create!(name: "Observers", email: "observers@sjaa.net", joinable: true)

    stub_google_api_general_error do
      patch person_path(@member), params: {
        person: {
          first_name: "Updated Name",
          last_name: @member.last_name,
          joinable_group_ids: [group.id]
        }
      }
    end

    @member.reload
    assert_equal "Updated Name", @member.first_name
    assert_includes @member.groups, group
    assert_response :redirect
  end

  # Members-only group enforcement tests
  test "update allows active member to join members_only group" do
    login_as_person(@member)

    members_only_group = Group.create!(
      name: "Members Only Group",
      email: "members-only@sjaa.net",
      joinable: true,
      members_only: true
    )

    patch person_path(@member), params: {
      person: {
        first_name: @member.first_name,
        last_name: @member.last_name,
        joinable_group_ids: [members_only_group.id]
      }
    }

    @member.reload
    assert_includes @member.groups, members_only_group
    assert_response :redirect
  end

  test "update removes non-active member from members_only group" do
    # Create an expired member
    expired_person = Person.create!(
      first_name: "Expired",
      last_name: "Member",
      password: "password123"
    )
    Contact.create!(
      email: "expired-test@example.com",
      person: expired_person,
      primary: true
    )
    Membership.create!(
      person: expired_person,
      start: 2.years.ago,
      term_months: 12,
      ephemeris: false
    )

    members_only_group = Group.create!(
      name: "Members Only Group",
      email: "members-only@sjaa.net",
      joinable: true,
      members_only: true
    )

    login_as_person(expired_person)

    patch person_path(expired_person), params: {
      person: {
        first_name: expired_person.first_name,
        last_name: expired_person.last_name,
        joinable_group_ids: [members_only_group.id]
      }
    }

    expired_person.reload
    assert_not_includes expired_person.groups, members_only_group
    assert_response :redirect

    # Should show warning in notice because they tried to join but were blocked
    assert_match /Members Only Group/, flash[:notice]
    assert_match /membership has expired/, flash[:notice]
    assert_match /renew your membership/, flash[:notice]
  end

  test "update allows non-active member to join public group" do
    # Create an expired member
    expired_person = Person.create!(
      first_name: "Expired",
      last_name: "Member2",
      password: "password123"
    )
    Contact.create!(
      email: "expired2@example.com",
      person: expired_person,
      primary: true
    )
    Membership.create!(
      person: expired_person,
      start: 2.years.ago,
      term_months: 12,
      ephemeris: false
    )

    public_group = Group.create!(
      name: "Public Group",
      email: "public@sjaa.net",
      joinable: true,
      members_only: false
    )

    login_as_person(expired_person)

    patch person_path(expired_person), params: {
      person: {
        first_name: expired_person.first_name,
        last_name: expired_person.last_name,
        joinable_group_ids: [public_group.id]
      }
    }

    expired_person.reload
    assert_includes expired_person.groups, public_group
    assert_response :redirect
  end

  test "update removes members_only groups when membership expires" do
    # Create a member with an expired membership
    expiring_person = Person.create!(
      first_name: "Expiring",
      last_name: "Member",
      password: "password123"
    )
    Contact.create!(
      email: "expiring@example.com",
      person: expiring_person,
      primary: true
    )
    # Create a membership that expired 1 month ago (started 13 months ago, 12 month term)
    Membership.create!(
      person: expiring_person,
      start: 13.months.ago,
      term_months: 12,
      ephemeris: false
    )

    members_only_group = Group.create!(
      name: "Members Only Group",
      email: "members-only@sjaa.net",
      joinable: true,
      members_only: true
    )
    public_group = Group.create!(
      name: "Public Group",
      email: "public@sjaa.net",
      joinable: true,
      members_only: false
    )

    # Add person to both groups initially (simulating they joined while active)
    expiring_person.groups << [members_only_group, public_group]
    expiring_person.save!

    login_as_person(expiring_person)

    # Update the person (any update triggers the enforcement)
    patch person_path(expiring_person), params: {
      person: {
        first_name: "Updated",
        last_name: expiring_person.last_name,
        joinable_group_ids: [members_only_group.id, public_group.id]
      }
    }

    expiring_person.reload
    assert_not_includes expiring_person.groups, members_only_group, "Expired member should be removed from members_only group"
    assert_includes expiring_person.groups, public_group, "Expired member should remain in public group"
    assert_response :redirect

    # Verify warning message is shown in notice
    assert_match /Members Only Group/, flash[:notice]
    assert_match /membership has expired/, flash[:notice]
    assert_match /renew your membership/, flash[:notice]
  end

  test "update shows no warning when no groups removed" do
    login_as_person(@member)

    public_group = Group.create!(
      name: "Public Group",
      email: "public@sjaa.net",
      joinable: true,
      members_only: false
    )

    patch person_path(@member), params: {
      person: {
        first_name: "Updated",
        last_name: @member.last_name,
        joinable_group_ids: [public_group.id]
      }
    }

    @member.reload
    assert_includes @member.groups, public_group
    assert_response :redirect
    assert_equal "Profile was successfully updated.", flash[:notice]
    assert_no_match /membership has expired/, flash[:notice], "Should not show warning when no groups are removed"
  end

  private

  def login_as_admin(admin)
    post sessions_path, params: { email: admin.email, password: 'password123' }
  end

  def login_as_person(person)
    person.reload if person.persisted? # Reload to ensure associations are loaded
    email = person.primary_contact&.email || person.email
    raise "Person #{person.id} has no email contact" if email.nil?
    post sessions_path, params: { email: email, password: 'password123' }
  end

  # Google API mocking helpers
  def stub_google_api_not_called
    Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, -> { raise "Google API should not be called" } do
      yield
    end
  end

  def stub_google_api_add_member(person_email, group_email)
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.insert_member(group, member)
      nil  # Success
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_remove_member(person_email, group_email)
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.delete_member(group, email)
      nil  # Success
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_add_multiple(person_email, group_emails)
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.insert_member(group, member)
      nil  # Success
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_remove_multiple(person_email, group_emails)
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.delete_member(group, email)
      nil  # Success
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_add_and_remove(person_email, groups_to_add, groups_to_remove)
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.insert_member(group, member)
      nil  # Success
    end
    def mock_client.delete_member(group, email)
      nil  # Success
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_duplicate_error
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.insert_member(group, member)
      error = Google::Apis::ClientError.new('Member already exists', status_code: 409)
      raise error
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_not_found_error
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.delete_member(group, email)
      error = Google::Apis::ClientError.new('Resource Not Found: memberKey', status_code: 404)
      raise error
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_general_error
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end
    def mock_client.insert_member(group, member)
      raise StandardError.new('Google API connection failed')
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end
end