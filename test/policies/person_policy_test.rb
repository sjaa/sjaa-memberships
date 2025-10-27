require 'test_helper'

class PersonPolicyTest < ActiveSupport::TestCase
  setup do
    @admin_with_read = Admin.create!(
      email: "admin_read@sjaa.net",
      password: "password123"
    )
    @read_permission = Permission.find_or_create_by(name: 'read')
    @admin_with_read.permissions << @read_permission

    @admin_with_write = Admin.create!(
      email: "admin_write@sjaa.net",
      password: "password123"
    )
    @write_permission = Permission.find_or_create_by(name: 'write')
    @admin_with_write.permissions << @write_permission

    @person_with_verify = Person.create!(
      first_name: "Verify",
      last_name: "User",
      password: "password123"
    )
    @verify_permission = Permission.find_or_create_by(name: 'verify_members')
    @person_with_verify.permissions << @verify_permission

    @person_with_read = Person.create!(
      first_name: "Read",
      last_name: "User",
      password: "password123"
    )
    @person_with_read.permissions << @read_permission

    @regular_person = Person.create!(
      first_name: "Regular",
      last_name: "User",
      password: "password123"
    )

    @target_person = Person.create!(
      first_name: "Target",
      last_name: "Person",
      password: "password123"
    )
  end

  # Verify permission tests
  test "admin with read permission can verify" do
    policy = PersonPolicy.new(@admin_with_read, @target_person)
    assert policy.verify?
  end

  test "person with verify_members permission can verify" do
    policy = PersonPolicy.new(@person_with_verify, @target_person)
    assert policy.verify?
  end

  test "person with read permission can verify" do
    policy = PersonPolicy.new(@person_with_read, @target_person)
    assert policy.verify?
  end

  test "regular person without permissions cannot verify" do
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.verify?
  end

  test "unauthenticated user cannot verify" do
    policy = PersonPolicy.new(nil, @target_person)
    assert_not policy.verify?
  end

  # Verify form permission tests
  test "verify_form? delegates to verify?" do
    # With permissions
    policy = PersonPolicy.new(@admin_with_read, @target_person)
    assert policy.verify_form?
    assert_equal policy.verify?, policy.verify_form?

    # Without permissions
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.verify_form?
    assert_equal policy.verify?, policy.verify_form?
  end

  # Show permission tests (existing functionality)
  test "admin with read permission can show any person" do
    policy = PersonPolicy.new(@admin_with_read, @target_person)
    assert policy.show?
  end

  test "person can show themselves" do
    policy = PersonPolicy.new(@regular_person, @regular_person)
    assert policy.show?
  end

  test "person cannot show other people without read permission" do
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.show?
  end

  # Update permission tests (existing functionality)
  test "admin with write permission can update any person" do
    policy = PersonPolicy.new(@admin_with_write, @target_person)
    assert policy.update?
  end

  test "person can update themselves" do
    policy = PersonPolicy.new(@regular_person, @regular_person)
    assert policy.update?
  end

  test "person cannot update other people without write permission" do
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.update?
  end

  # Search permission tests (existing functionality)
  test "admin with read permission can search" do
    policy = PersonPolicy.new(@admin_with_read, @target_person)
    assert policy.search?
  end

  test "person with read permission can search" do
    policy = PersonPolicy.new(@person_with_read, @target_person)
    assert policy.search?
  end

  test "regular person cannot search" do
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.search?
  end

  # Remind permission tests (existing functionality)
  test "admin with write permission can send reminders" do
    policy = PersonPolicy.new(@admin_with_write, @target_person)
    assert policy.remind?
    assert policy.remind_all?
    assert policy.welcome?
  end

  test "person without write permission cannot send reminders" do
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.remind?
    assert_not policy.remind_all?
    assert_not policy.welcome?
  end

  # Membership-related permission tests (existing functionality)
  test "admin with write permission can manage memberships" do
    policy = PersonPolicy.new(@admin_with_write, @target_person)
    assert policy.new_membership?
    assert policy.create_membership?
  end

  test "person can manage their own memberships" do
    policy = PersonPolicy.new(@regular_person, @regular_person)
    assert policy.new_membership?
    assert policy.create_membership?
  end

  test "person cannot manage other people's memberships without write permission" do
    policy = PersonPolicy.new(@regular_person, @target_person)
    assert_not policy.new_membership?
    assert_not policy.create_membership?
  end
end