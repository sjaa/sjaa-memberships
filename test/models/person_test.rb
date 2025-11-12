require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @referral = Referral.create!(name: 'internet', description: 'Web search')
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      referral: @referral
    )
    @contact = Contact.create!(
      email: 'john@example.com',
      person: @person,
      primary: true
    )
  end

  test 'valid person with required attributes' do
    assert @person.valid?
    assert_equal 'John Doe', @person.name
  end

  test 'person can have multiple contacts' do
    secondary_contact = Contact.create!(
      email: 'john.work@example.com',
      person: @person,
      primary: false
    )
    
    assert_equal 2, @person.contacts.count
    assert_equal @contact, @person.primary_contact
  end

  test 'find_by_email returns person for primary contact email' do
    found_person = Person.find_by_email(@contact.email)
    assert_equal @person, found_person
  end

  test 'find_by_email returns person for any contact email' do
    secondary_contact = Contact.create!(
      email: 'john.alt@example.com',
      person: @person,
      primary: false
    )
    
    found_person = Person.find_by_email(secondary_contact.email)
    assert_equal @person, found_person
  end

  test 'find_by_email returns nil for non-existent email' do
    found_person = Person.find_by_email('nonexistent@example.com')
    assert_nil found_person
  end

  test 'person status reflects membership status' do
    # Person with no membership
    assert_equal 'Expired', @person.status
    assert_not @person.is_active?
    
    # Person with active membership
    Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    @person.reload
    assert_equal 'Active', @person.status
    assert @person.is_active?
  end

  test 'lifetime member status' do
    Membership.create!(
      person: @person,
      start: Date.current,
      term_months: nil # lifetime membership
    )
    
    @person.reload
    assert @person.is_lifetime_member
    assert @person.is_active?
    assert_equal 'Active', @person.status
  end

  test 'next_membership_start_date for new member' do
    # No existing memberships
    assert_equal Date.today, @person.next_membership_start_date
  end

  test 'next_membership_start_date for active member' do
    membership = Membership.create!(
      person: @person,
      start: Date.current.beginning_of_month,
      term_months: 12
    )
    
    @person.reload
    expected_date = membership.end.beginning_of_month
    assert_equal expected_date, @person.next_membership_start_date
  end

  test 'next_membership_start_date for lifetime member returns nil' do
    Membership.create!(
      person: @person,
      start: Date.current,
      term_months: nil # lifetime membership
    )
    
    @person.reload
    assert_nil @person.next_membership_start_date
  end

  test 'latest_membership returns most recent membership' do
    old_membership = Membership.create!(
      person: @person,
      start: 1.year.ago,
      term_months: 12
    )
    
    recent_membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    assert_equal recent_membership, @person.latest_membership
  end

  test 'first_membership returns earliest membership' do
    recent_membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    first_membership = Membership.create!(
      person: @person,
      start: 2.years.ago,
      term_months: 12
    )
    
    assert_equal first_membership, @person.first_membership
  end

  test 'active_membership returns current active membership' do
    # Expired membership
    Membership.create!(
      person: @person,
      start: 2.years.ago,
      term_months: 12
    )
    
    # Active membership
    active_membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )
    
    assert_equal active_membership, @person.active_membership.first
  end

  test 'password reset functionality through PasswordResettable concern' do
    assert_respond_to @person, :generate_password_reset_token!
    assert_respond_to @person, :password_reset_token_valid?
    assert_respond_to @person, :reset_password!
    
    @person.generate_password_reset_token!
    assert_not_nil @person.reset_password_token
    assert @person.password_reset_token_valid?
    
    @person.reset_password!('newpassword')
    assert @person.authenticate('newpassword')
    assert_nil @person.reset_password_token
  end

  test 'person has no permissions by default' do
    assert_not @person.has_permission?('read')
    assert_not @person.has_permission?('write')
    assert_not @person.has_permission?('permit')
  end

  test 'person can have api keys' do
    api_key = ApiKey.create!(bearer: @person, token: 'test_token_123')
    assert_includes @person.api_keys, api_key
  end

  test 'person can have memberships, donations, equipment, and contacts' do
    membership = Membership.create!(person: @person, start: Date.current, term_months: 12)
    donation = Donation.create!(person: @person, name: 'Test Donation')

    assert_includes @person.memberships, membership
    assert_includes @person.donations, donation
    assert_includes @person.contacts, @contact
  end

  # joinable_group_ids= tests (for user self-management)
  test 'joinable_group_ids= can set joinable groups' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    role2 = Group.create!(name: 'Volunteers', email: 'volunteers@sjaa.net', joinable: true)

    @person.joinable_group_ids = [role1.id, role2.id]

    assert_equal 2, @person.groups.count
    assert_includes @person.groups, role1
    assert_includes @person.groups, role2
  end

  test 'joinable_group_ids= can remove all joinable groups with empty array' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    role2 = Group.create!(name: 'Volunteers', email: 'volunteers@sjaa.net', joinable: true)

    @person.groups << [role1, role2]
    assert_equal 2, @person.groups.count

    # Empty array with hidden field [""] should remove all joinable groups
    @person.joinable_group_ids = [""]

    assert_equal 0, @person.groups.count
  end

  test 'joinable_group_ids= filters out empty strings from hidden field' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)

    # Simulates form submission with hidden field: ["", role1.id]
    @person.joinable_group_ids = ["", role1.id]

    assert_equal 1, @person.groups.count
    assert_includes @person.groups, role1
  end

  test 'joinable_group_ids= ignores non-joinable group IDs' do
    joinable_group = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    non_joinable_group = Group.create!(name: 'Board Member', email: 'board@sjaa.net', joinable: false)

    # User tries to add themselves to a non-joinable role
    @person.joinable_group_ids = [joinable_group.id, non_joinable_group.id]

    # Only joinable group should be added
    assert_equal 1, @person.groups.count
    assert_includes @person.groups, joinable_group
    assert_not_includes @person.groups, non_joinable_group
  end

  test 'joinable_group_ids= updates existing group assignments correctly' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    role2 = Group.create!(name: 'Volunteers', email: 'volunteers@sjaa.net', joinable: true)
    role3 = Group.create!(name: 'Educators', email: 'edu@sjaa.net', joinable: true)

    # Set initial groups
    @person.joinable_group_ids = [role1.id, role2.id]
    assert_equal 2, @person.groups.count

    # Update to different groups
    @person.joinable_group_ids = [role2.id, role3.id]

    assert_equal 2, @person.groups.count
    assert_not_includes @person.groups, role1
    assert_includes @person.groups, role2
    assert_includes @person.groups, role3
  end

  test 'joinable_group_ids= preserves non-joinable groups when setting joinable groups' do
    joinable_group = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    non_joinable_group = Group.create!(name: 'Board Member', email: 'board@sjaa.net', joinable: false)

    # Add a non-joinable group (admin-set)
    @person.groups << non_joinable_group
    assert_equal 1, @person.groups.count

    # User adds themselves to a joinable role
    @person.joinable_group_ids = [joinable_group.id]

    assert_equal 2, @person.groups.count
    assert_includes @person.groups, joinable_group
    assert_includes @person.groups, non_joinable_group
  end

  test 'joinable_group_ids= preserves non-joinable groups when removing all joinable groups' do
    joinable_group = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    non_joinable_group = Group.create!(name: 'Board Member', email: 'board@sjaa.net', joinable: false)

    @person.groups << [joinable_group, non_joinable_group]
    assert_equal 2, @person.groups.count

    # User removes all joinable groups (empty array with hidden field [""])
    @person.joinable_group_ids = [""]

    assert_equal 1, @person.groups.count
    assert_includes @person.groups, non_joinable_group
    assert_not_includes @person.groups, joinable_group
  end

  test 'groups_attributes= allows admin to set mix of joinable and non-joinable groups' do
    joinable_group = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    non_joinable_group = Group.create!(name: 'Board Member', email: 'board@sjaa.net', joinable: false)

    # Admin sets both types of groups
    @person.groups_attributes = [{id: joinable_group.id}, {id: non_joinable_group.id}]

    assert_equal 2, @person.groups.count
    assert_includes @person.groups, joinable_group
    assert_includes @person.groups, non_joinable_group
  end

  test 'groups_attributes= allows admin to remove all groups including non-joinable' do
    joinable_group = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    non_joinable_group = Group.create!(name: 'Board Member', email: 'board@sjaa.net', joinable: false)

    @person.groups << [joinable_group, non_joinable_group]
    assert_equal 2, @person.groups.count

    # Admin sends only non-joinable groups (effectively removing joinable)
    @person.groups_attributes = [{id: non_joinable_group.id}]

    assert_equal 1, @person.groups.count
    assert_includes @person.groups, non_joinable_group
    assert_not_includes @person.groups, joinable_group
  end

  test 'groups_attributes= handles nil IDs gracefully' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)

    # Simulates weird form data with nil values
    @person.groups_attributes = [{id: nil}, {id: role1.id}, {id: nil}]

    assert_equal 1, @person.groups.count
    assert_includes @person.groups, role1
  end

  test 'groups_attributes= handles mixed blank values' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    role2 = Group.create!(name: 'Volunteers', email: 'volunteers@sjaa.net', joinable: true)

    # Simulates form with various blank values
    @person.groups_attributes = [{id: ""}, {id: role1.id}, {id: nil}, {id: role2.id}, {id: ""}]

    assert_equal 2, @person.groups.count
    assert_includes @person.groups, role1
    assert_includes @person.groups, role2
  end

  test 'groups_attributes= updates existing group assignments correctly' do
    role1 = Group.create!(name: 'Observers', email: 'observers@sjaa.net', joinable: true)
    role2 = Group.create!(name: 'Volunteers', email: 'volunteers@sjaa.net', joinable: true)
    role3 = Group.create!(name: 'Educators', email: 'edu@sjaa.net', joinable: true)

    # Set initial groups
    @person.groups << [role1, role2]
    assert_equal 2, @person.groups.count

    # Update to different groups
    @person.groups_attributes = [{id: role2.id}, {id: role3.id}]

    assert_equal 2, @person.groups.count
    assert_not_includes @person.groups, role1
    assert_includes @person.groups, role2
    assert_includes @person.groups, role3
  end

  # Permission-related tests
  test 'person can be assigned permissions' do
    permission = Permission.create!(name: 'verify_members')
    @person.permissions << permission

    assert_equal 1, @person.permissions.count
    assert_includes @person.permissions, permission
  end

  test 'has_permission? returns true for assigned permissions' do
    permission = Permission.create!(name: 'verify_members')
    @person.permissions << permission

    assert @person.has_permission?('verify_members')
    assert @person.has_permission?(:verify_members)
  end

  test 'has_permission? returns false for unassigned permissions' do
    assert_not @person.has_permission?('verify_members')
    assert_not @person.has_permission?(:verify_members)
  end

  test 'permission_attributes= assigns permissions correctly' do
    read_permission = Permission.create!(name: 'read')
    write_permission = Permission.create!(name: 'write')
    verify_permission = Permission.create!(name: 'verify_members')

    @person.permission_attributes = [read_permission.id, verify_permission.id]

    assert_equal 2, @person.permissions.count
    assert_includes @person.permissions, read_permission
    assert_includes @person.permissions, verify_permission
    assert_not_includes @person.permissions, write_permission
  end

  test 'permission_attributes= replaces existing permissions' do
    read_permission = Permission.create!(name: 'read')
    write_permission = Permission.create!(name: 'write')
    verify_permission = Permission.create!(name: 'verify_members')

    # Set initial permissions
    @person.permissions << [read_permission, write_permission]
    assert_equal 2, @person.permissions.count

    # Replace with different permissions
    @person.permission_attributes = [verify_permission.id]

    assert_equal 1, @person.permissions.count
    assert_includes @person.permissions, verify_permission
    assert_not_includes @person.permissions, read_permission
    assert_not_includes @person.permissions, write_permission
  end

  test 'permission_attributes= handles empty array' do
    permission = Permission.create!(name: 'verify_members')
    @person.permissions << permission
    assert_equal 1, @person.permissions.count

    @person.permission_attributes = []

    assert_equal 0, @person.permissions.count
  end

  test 'permission_attributes= ignores invalid permission IDs' do
    valid_permission = Permission.create!(name: 'verify_members')

    @person.permission_attributes = [valid_permission.id, 99999]

    assert_equal 1, @person.permissions.count
    assert_includes @person.permissions, valid_permission
  end

  # Verification-related method tests
  test 'find_by_email is case sensitive' do
    # Test with exact case
    found_person = Person.find_by_email(@contact.email)
    assert_equal @person, found_person

    # Test with different case - should return nil (case sensitive)
    found_person = Person.find_by_email(@contact.email.upcase)
    assert_nil found_person
  end

  # Skills management tests
  test 'skills_attributes= creates new skill associations' do
    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')

    @person.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 1 }
    ]
    @person.save!

    assert_equal 2, @person.people_skills.count
    assert_equal 2, @person.skills.count

    ps1 = @person.people_skills.find_by(skill: skill1)
    assert_equal 'intermediate', ps1.skill_level

    ps2 = @person.people_skills.find_by(skill: skill2)
    assert_equal 'beginner', ps2.skill_level
  end

  test 'skills_attributes= updates existing skill associations' do
    skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    # Create initial skill association
    @person.skills_attributes = [
      { skill_id: skill.id, skill_level: 1 }
    ]
    @person.save!

    assert_equal 1, @person.people_skills.count
    ps = @person.people_skills.first
    assert_equal 'beginner', ps.skill_level

    # Update the skill levels
    @person.skills_attributes = [
      { skill_id: skill.id, skill_level: 3 }
    ]
    @person.save!

    @person.reload
    assert_equal 1, @person.people_skills.count
    ps = @person.people_skills.first
    assert_equal 'advanced', ps.skill_level
  end

  test 'skills_attributes= removes skills not in the list' do
    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')
    skill3 = Skill.create!(name: 'Teaching', description: 'Education')

    # Add all three skills
    @person.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 1 },
      { skill_id: skill3.id, skill_level: 2 }
    ]
    @person.save!
    assert_equal 3, @person.people_skills.count

    # Update to only include skill1 and skill3
    @person.skills_attributes = [
      { skill_id: skill1.id, skill_level: 3 },
      { skill_id: skill3.id, skill_level: 2 }
    ]
    @person.save!

    @person.reload
    assert_equal 2, @person.people_skills.count
    assert_includes @person.skills, skill1
    assert_not_includes @person.skills, skill2
    assert_includes @person.skills, skill3
  end

  test 'skills_attributes= ignores skills with level at 0' do
    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')

    @person.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 0 }
    ]
    @person.save!

    assert_equal 1, @person.people_skills.count
    assert_includes @person.skills, skill1
    assert_not_includes @person.skills, skill2
  end

  test 'skills_attributes= handles all valid skill levels' do
    skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    @person.skills_attributes = [
      { skill_id: skill.id, skill_level: 3 }
    ]
    @person.save!

    assert_equal 1, @person.people_skills.count
    ps = @person.people_skills.first
    assert_equal 'advanced', ps.skill_level
  end

  test 'skills_attributes= ignores blank skill_id' do
    skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    @person.skills_attributes = [
      { skill_id: skill.id, skill_level: 2 },
      { skill_id: '', skill_level: 1 },
      { skill_id: nil, skill_level: 2 }
    ]
    @person.save!

    assert_equal 1, @person.people_skills.count
    assert_includes @person.skills, skill
  end

  test 'skills_attributes= converts string values to integers' do
    skill = Skill.create!(name: 'Photography', description: 'Astrophotography')

    @person.skills_attributes = [
      { skill_id: skill.id.to_s, skill_level: '2' }
    ]
    @person.save!

    ps = @person.people_skills.first
    assert_equal 'intermediate', ps.skill_level
  end

  test 'skills_attributes= removes all skills with empty array' do
    skill1 = Skill.create!(name: 'Photography', description: 'Astrophotography')
    skill2 = Skill.create!(name: 'Event Planning', description: 'Organizing events')

    # Add skills
    @person.skills_attributes = [
      { skill_id: skill1.id, skill_level: 2 },
      { skill_id: skill2.id, skill_level: 1 }
    ]
    @person.save!
    assert_equal 2, @person.people_skills.count

    # Remove all skills
    @person.skills_attributes = []
    @person.save!

    @person.reload
    assert_equal 0, @person.people_skills.count
  end

end