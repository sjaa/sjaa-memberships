require "test_helper"
require "minitest/mock"

class GoogleGroupSyncJobTest < ActiveJob::TestCase
  include GoogleHelper

  setup do
    # Create test admin with refresh token
    @admin = Admin.create!(
      email: 'admin@sjaa.net',
      password: 'password123',
      refresh_token: 'test_refresh_token'
    )

    # Create test group
    @group = Group.create!(
      name: 'Test Group',
      email: 'test-group@sjaa.net',
      joinable: true,
      members_only: true
    )

    # Create active member
    @active_person = Person.create!(
      first_name: 'Active',
      last_name: 'Member',
      password: 'password123'
    )

    Contact.create!(
      person: @active_person,
      email: 'active@example.com'
    )

    Membership.create!(
      person: @active_person,
      start: Date.current,
      term_months: 12
    )

    # Add person to group
    @active_person.groups << @group

    # Create expired member
    @expired_person = Person.create!(
      first_name: 'Expired',
      last_name: 'Member',
      password: 'password123'
    )

    Contact.create!(
      person: @expired_person,
      email: 'expired@example.com'
    )

    Membership.create!(
      person: @expired_person,
      start: 2.years.ago,
      term_months: 12
    )

    @expired_person.groups << @group
  end

  test "job queues successfully" do
    assert_enqueued_with(job: GoogleGroupSyncJob) do
      GoogleGroupSyncJob.perform_later(@admin.email, @group.email, group_id: @group.id)
    end
  end

  test "job does not run when admin has no refresh token" do
    admin_no_token = Admin.create!(
      email: 'noaccess@sjaa.net',
      password: 'password123',
      refresh_token: nil
    )

    stub_google_api_not_called do
      GoogleGroupSyncJob.perform_now(admin_no_token.email, @group.email, group_id: @group.id)
    end

    assert true
  end

  test "job does not run when admin does not exist" do
    stub_google_api_not_called do
      GoogleGroupSyncJob.perform_now('nonexistent@sjaa.net', @group.email, group_id: @group.id)
    end

    assert true
  end

  test "job does not run when group does not exist" do
    stub_google_api_not_called do
      GoogleGroupSyncJob.perform_now(@admin.email, @group.email, group_id: 999999)
    end

    assert true
  end

  test "job syncs group successfully" do
    stub_google_api_sync do
      GoogleGroupSyncJob.perform_now(
        @admin.email,
        @group.email,
        group_id: @group.id,
        members_only: true,
        use_remove_group: false
      )
    end

    assert true
  end

  test "job uses remove group when enabled" do
    remove_group_calls = []

    stub_google_api_sync_with_remove_group(remove_group_calls) do
      GoogleGroupSyncJob.perform_now(
        @admin.email,
        @group.email,
        group_id: @group.id,
        use_remove_group: true,
        remove_group: 'expired-members@sjaa.net',
        clear_remove_group: true
      )
    end

    # Verify remove group was accessed
    assert remove_group_calls.any? { |call| call[:method] == :list_members && call[:group] == 'expired-members@sjaa.net' },
      "Expected remove group to be accessed"
  end

  test "job does not clear remove group when clear_remove_group is false" do
    delete_calls = []

    stub_google_api_sync_track_deletes(delete_calls) do
      GoogleGroupSyncJob.perform_now(
        @admin.email,
        @group.email,
        group_id: @group.id,
        use_remove_group: true,
        remove_group: 'expired-members@sjaa.net',
        clear_remove_group: false
      )
    end

    # Verify no deletes from remove group
    remove_group_deletes = delete_calls.select { |call| call[:group] == 'expired-members@sjaa.net' }
    assert_equal 0, remove_group_deletes.size, "Expected no deletes from remove group when clear_remove_group is false"
  end

  test "job does not remove admin from remove group" do
    delete_calls = []

    stub_google_api_sync_track_deletes(delete_calls) do
      GoogleGroupSyncJob.perform_now(
        @admin.email,
        @group.email,
        group_id: @group.id,
        use_remove_group: true,
        remove_group: 'expired-members@sjaa.net',
        clear_remove_group: true
      )
    end

    # Verify admin was not deleted from remove group
    admin_deleted = delete_calls.any? do |call|
      call[:group] == 'expired-members@sjaa.net' &&
      call[:email]&.downcase == @admin.email.downcase
    end

    assert_not admin_deleted, "Admin should not be deleted from remove group"
  end

  test "job only adds members when add_only is true" do
    delete_calls = []
    insert_calls = []

    stub_google_api_sync_track_all(delete_calls, insert_calls) do
      GoogleGroupSyncJob.perform_now(
        @admin.email,
        @group.email,
        group_id: @group.id,
        add_only: true,
        use_remove_group: false
      )
    end

    # Verify no deletes from main group
    main_group_deletes = delete_calls.select { |call| call[:group] == @group.email }
    assert_equal 0, main_group_deletes.size, "Expected no deletes from main group when add_only is true"
  end

  test "job handles Google API errors gracefully" do
    stub_google_api_error do
      assert_raises Google::Apis::ClientError do
        GoogleGroupSyncJob.perform_now(@admin.email, @group.email, group_id: @group.id)
      end
    end
  end

  test "job uses default remove group when not specified" do
    remove_group_calls = []

    stub_google_api_sync_with_remove_group(remove_group_calls) do
      GoogleGroupSyncJob.perform_now(
        @admin.email,
        @group.email,
        group_id: @group.id,
        use_remove_group: true,
        clear_remove_group: true
      )
    end

    # Verify default REMOVE_GROUP was used
    default_group = GoogleHelper::REMOVE_GROUP
    assert remove_group_calls.any? { |call| call[:group] == default_group },
      "Expected default remove group #{default_group} to be used"
  end

  private

  def stub_google_api_not_called
    # Stub DirectoryService.new to raise error if called
    Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, -> { raise "Google API should not be called" } do
      yield
    end
  end

  def stub_google_api_sync
    mock_auth = Object.new
    mock_client = create_mock_client

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_sync_with_remove_group(calls_tracker)
    mock_auth = Object.new
    mock_client = create_mock_client(calls_tracker)

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_sync_track_deletes(delete_calls)
    mock_auth = Object.new
    mock_client = create_mock_client([], delete_calls)

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_sync_track_all(delete_calls, insert_calls)
    mock_auth = Object.new
    mock_client = create_mock_client([], delete_calls, insert_calls)

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def stub_google_api_error
    mock_auth = Object.new
    mock_client = Object.new

    def mock_client.authorization=(auth); end

    def mock_client.list_members(group, page_token: nil)
      raise Google::Apis::ClientError.new('Server Error', status_code: 500)
    end

    self.stub :get_auth, mock_auth do
      Google::Apis::AdminDirectoryV1::DirectoryService.stub :new, mock_client do
        yield
      end
    end
  end

  def create_mock_client(calls_tracker = [], delete_calls = [], insert_calls = [])
    mock_client = Object.new

    # Track calls
    mock_client.instance_variable_set(:@calls_tracker, calls_tracker)
    mock_client.instance_variable_set(:@delete_calls, delete_calls)
    mock_client.instance_variable_set(:@insert_calls, insert_calls)

    def mock_client.authorization=(auth); end

    def mock_client.list_members(group, page_token: nil)
      @calls_tracker << { method: :list_members, group: group, page_token: page_token }

      # Return mock response with admin user in remove group
      members = []
      if group.include?('expired') || group.include?('remove')
        admin_member = Google::Apis::AdminDirectoryV1::Member.new(email: 'admin@sjaa.net')
        members << admin_member
      end

      Google::Apis::AdminDirectoryV1::Members.new(members: members, next_page_token: nil)
    end

    def mock_client.delete_member(group, email)
      @delete_calls << { method: :delete_member, group: group, email: email }
      nil
    end

    def mock_client.insert_member(group, member)
      @insert_calls << { method: :insert_member, group: group, email: member.email }
      nil
    end

    mock_client
  end
end
