require "test_helper"

class AddMemberToGroupJobTest < ActiveJob::TestCase
  include GoogleHelper

  setup do
    @person = Person.create!(
      first_name: 'Jane',
      last_name: 'Smith',
      password: 'password123'
    )

    Contact.create!(
      person: @person,
      email: 'jane.smith@example.com'
    )

    @membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: 12
    )

    @admin = Admin.create!(
      email: 'admin@sjaa.net',
      password: 'password123',
      refresh_token: 'test_refresh_token'
    )

    # Track whether Google API was called
    @api_called = false
  end

  test "job is enqueued when membership is created" do
    new_person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123'
    )

    Contact.create!(
      person: new_person,
      email: 'john.doe@example.com'
    )

    assert_enqueued_with(job: AddMemberToGroupJob) do
      Membership.create!(
        person: new_person,
        start: Date.current,
        term_months: 12
      )
    end
  end

  test "job does not call Google API when person has no email" do
    person_without_email = Person.create!(
      first_name: 'No',
      last_name: 'Email',
      password: 'password123'
    )

    # Stub DirectoryService to track if it's instantiated
    stub_google_api_not_called do
      AddMemberToGroupJob.perform_now(person_without_email.id, @admin.email)
    end

    # If we got here without errors, the API was not called (WebMock would have raised)
    assert true
  end

  test "job does not call Google API when person is inactive" do
    expired_person = Person.create!(
      first_name: 'Expired',
      last_name: 'Member',
      password: 'password123'
    )

    Contact.create!(
      person: expired_person,
      email: 'expired@example.com'
    )

    # Create expired membership
    Membership.create!(
      person: expired_person,
      start: 2.years.ago,
      term_months: 12
    )

    stub_google_api_not_called do
      AddMemberToGroupJob.perform_now(expired_person.id, @admin.email)
    end

    assert_not expired_person.is_active?
  end

  test "job does not call Google API when person does not exist" do
    stub_google_api_not_called do
      AddMemberToGroupJob.perform_now(999999, @admin.email)
    end

    assert true
  end

  test "job does not call Google API when admin has no refresh token" do
    admin_no_token = Admin.create!(
      email: 'noaccess@sjaa.net',
      password: 'password123',
      refresh_token: nil
    )

    stub_google_api_not_called do
      AddMemberToGroupJob.perform_now(@person.id, admin_no_token.email)
    end

    assert true
  end

  test "job attempts to add member to group for active member with email" do
    stub_google_api_add_member('jane.smith@example.com') do
      AddMemberToGroupJob.perform_now(@person.id, @admin.email)
    end

    assert @api_called, "Expected Google API to be called for active member with email"
  end

  test "job skips adding member if already in group" do
    stub_google_api_member_exists('jane.smith@example.com') do
      AddMemberToGroupJob.perform_now(@person.id, @admin.email)
    end

    assert @api_called, "Expected Google API insert_member to be called"
  end

  test "job handles Google API errors gracefully" do
    stub_google_api_error do
      assert_raises Google::Apis::ClientError do
        AddMemberToGroupJob.perform_now(@person.id, @admin.email)
      end
    end
  end

  test "membership creation callback uses admin with refresh token" do
    assert_not_nil @admin.refresh_token

    new_person = Person.create!(
      first_name: 'Test',
      last_name: 'User',
      password: 'password123'
    )

    Contact.create!(
      person: new_person,
      email: 'test.user@example.com'
    )

    assert_enqueued_jobs 1, only: AddMemberToGroupJob do
      Membership.create!(
        person: new_person,
        start: Date.current,
        term_months: 12
      )
    end
  end

  private

  def stub_google_api_not_called
    # Stub DirectoryService.new to raise error if called
    Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, -> { raise "Google API should not be called" } do
      yield
    end
  end

  def stub_google_api_add_member(expected_email)
    mock_auth = Object.new
    mock_client = Object.new

    # Define stubbed methods on mock_client
    def mock_client.authorization=(auth); end

    def mock_client.get_member(group, email)
      @get_member_called = true
      raise Google::Apis::ClientError.new('Not Found', status_code: 404)
    end

    def mock_client.insert_member(group, member)
      @insert_member_called = true
      @api_called = true
      nil
    end

    # Stub the helper method
    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        result = yield
        @api_called = mock_client.instance_variable_get(:@insert_member_called) || false
        result
      end
    end
  end

  def stub_google_api_member_exists(expected_email)
    mock_auth = Object.new
    mock_client = Object.new

    # Define stubbed methods on mock_client
    def mock_client.authorization=(auth); end

    def mock_client.insert_member(group, member)
      @insert_member_called = true
      @api_called = true
      # Raise 409 Conflict error to simulate member already exists
      raise Google::Apis::ClientError.new('Member already exists', status_code: 409)
    end

    # Stub the helper method
    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        result = yield
        @api_called = mock_client.instance_variable_get(:@insert_member_called) || false
        result
      end
    end
  end

  def stub_google_api_error
    mock_auth = Object.new
    mock_client = Object.new

    # Define stubbed methods on mock_client
    def mock_client.authorization=(auth); end

    def mock_client.insert_member(group, member)
      raise Google::Apis::ClientError.new('Server Error', status_code: 500)
    end

    # Stub the helper method
    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end
end
