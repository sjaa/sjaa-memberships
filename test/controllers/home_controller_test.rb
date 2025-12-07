require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123"
    )

    @read_permission = Permission.find_or_create_by(name: 'read')
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
  end

  test "root redirects regular members to their profile" do
    login_as_person(@regular_person)
    get root_path
    assert_redirected_to person_path(@regular_person)
    assert_equal 'Welcome back! Here is your profile.', flash[:notice]
  end

  test "root redirects person with read permission to people index" do
    login_as_person(@person_with_read)
    get root_path
    assert_redirected_to people_path
  end

  test "root redirects admin to people index" do
    login_as_admin(@admin)
    get root_path
    assert_redirected_to people_path
  end

  private

  def login_as_admin(admin)
    post sessions_path, params: { email: admin.email, password: 'password123' }
  end

  def login_as_person(person)
    person.reload if person.persisted?
    email = person.primary_contact&.email || person.email
    raise "Person #{person.id} has no email contact" if email.nil?
    post sessions_path, params: { email: email, password: 'password123' }
  end
end
