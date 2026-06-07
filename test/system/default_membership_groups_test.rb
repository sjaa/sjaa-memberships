require "application_system_test_case"

class DefaultMembershipGroupsTest < ApplicationSystemTestCase
  setup do
    @admin = Admin.create!(email: "admin@sjaa.net", password: "password123")
    write_permission = Permission.find_or_create_by(name: "write")
    @admin.permissions << write_permission

    @default_group = Group.create!(
      name: "General Members",
      email: "general@sjaa.net",
      joinable: true,
      default_membership: true
    )
    @opt_in_group = Group.create!(
      name: "Deep Sky Observers",
      email: "dso@sjaa.net",
      joinable: true,
      default_membership: false
    )
  end

  test "new person form does not pre-select any groups before payment" do
    login_as("admin@sjaa.net", "password123")
    visit new_person_path

    # Even default_membership groups should NOT be pre-selected in the form —
    # they are added automatically on first membership creation instead.
    assert_selector "input[type=checkbox][value='#{@default_group.id}']:not(:checked)",
                    visible: :hidden
    assert_selector "input[type=checkbox][value='#{@opt_in_group.id}']:not(:checked)",
                    visible: :hidden
  end

  test "existing person form shows their current groups" do
    existing_person = Person.create!(first_name: "Existing", last_name: "Person", password: "pw")
    Contact.create!(email: "existing@example.com", person: existing_person, primary: true)
    existing_person.groups << @opt_in_group

    login_as("admin@sjaa.net", "password123")
    visit edit_person_path(existing_person)

    assert_selector "input[type=checkbox][value='#{@opt_in_group.id}']:checked",
                    visible: :hidden
    assert_selector "input[type=checkbox][value='#{@default_group.id}']:not(:checked)",
                    visible: :hidden
  end
end
