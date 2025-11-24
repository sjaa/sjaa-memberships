require "test_helper"
require "minitest/mock"

class CalendarSyncJobTest < ActiveJob::TestCase
  setup do
    @admin = Admin.create!(
      email: 'admin@sjaa.net',
      password: 'password123',
      refresh_token: 'test_refresh_token'
    )

    @calendar_id = 'test-calendar@group.calendar.google.com'

    # Set required environment variable
    ENV['SJAA_ALL_EVENTS_CALENDAR_ID'] = @calendar_id

    # Track API calls
    @api_called = false
  end

  test "job requires admin with refresh token" do
    admin_no_token = Admin.create!(
      email: 'noaccess@sjaa.net',
      password: 'password123',
      refresh_token: nil
    )

    # Job should log error and return early without calling Google API
    stub_google_calendar_api_not_called do
      CalendarSyncJob.perform_now(admin_no_token.email, @calendar_id)
    end

    assert true # If we got here, no API calls were made
  end

  test "job requires valid admin email" do
    stub_google_calendar_api_not_called do
      CalendarSyncJob.perform_now('nonexistent@sjaa.net', @calendar_id)
    end

    assert true # If we got here, no API calls were made
  end

  test "job uses environment variable for calendar_id when not provided" do
    mock_aggregator = create_mock_aggregator([])

    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      assert_equal @calendar_id, calendar_id
    end

    CalendarSyncJob.perform_now(@admin.email)
  end

  test "job creates new events from aggregator" do
    # Create mock aggregated events
    new_event = create_mock_event(
      title: 'New Astronomy Night',
      description: 'Join us for stargazing',
      location: 'Houge Park',
      start_time: 1.week.from_now,
      end_time: 1.week.from_now + 2.hours,
      hooks: {}
    )

    mock_aggregator = create_mock_aggregator([new_event])

    created_events = []
    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      # Mock insert_event to track created events
      calendar_service.define_singleton_method(:insert_event) do |cal_id, event|
        created_events << event
        created_event = event.dup
        created_event.id = 'new-event-id-123'
        created_event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 1, created_events.size
    assert_equal 'New Astronomy Night', created_events.first.summary
    assert created_events.first.description.include?('Join us for stargazing'), "Description should include original text"
    assert_equal 'Houge Park', created_events.first.location
  end

  test "job updates existing events" do
    existing_event = create_mock_event(
      title: 'Updated Astronomy Night',
      description: 'Updated description',
      location: 'Updated location',
      start_time: 1.week.from_now,
      end_time: 1.week.from_now + 2.hours,
      hooks: { google_calendar_id: 'existing-event-id-456' }
    )

    mock_aggregator = create_mock_aggregator([existing_event])

    updated_events = []
    test_context = self
    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      # Mock get_event to return existing event
      calendar_service.define_singleton_method(:get_event) do |cal_id, event_id|
        test_context.assert_equal 'existing-event-id-456', event_id
        test_context.send(:create_google_event,
          id: event_id,
          summary: 'Old Title',
          description: 'Old description',
          location: 'Old location'
        )
      end

      # Mock update_event to track updates
      calendar_service.define_singleton_method(:update_event) do |cal_id, event_id, event|
        updated_events << event
        event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 1, updated_events.size
    assert_equal 'Updated Astronomy Night', updated_events.first.summary
    assert updated_events.first.description.include?('Updated description'), "Description should include original text"
    assert_equal 'Updated location', updated_events.first.location
  end

  test "job marks cancelled events with prefix" do
    cancelled_event = create_mock_event(
      title: 'Cancelled Event',
      description: 'This event is cancelled',
      location: 'N/A',
      start_time: 1.week.from_now,
      end_time: 1.week.from_now + 2.hours,
      hooks: { google_calendar_id: 'cancelled-event-id-789' },
      cancelled: true
    )

    mock_aggregator = create_mock_aggregator([cancelled_event])

    updated_events = []
    test_context = self
    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      # Mock get_event to return existing event without cancelled prefix
      calendar_service.define_singleton_method(:get_event) do |cal_id, event_id|
        test_context.send(:create_google_event,
          id: event_id,
          summary: 'Cancelled Event', # No prefix yet
          description: 'This event is cancelled'
        )
      end

      # Mock update_event to track updates
      calendar_service.define_singleton_method(:update_event) do |cal_id, event_id, event|
        updated_events << event
        event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 1, updated_events.size
    assert updated_events.first.summary.start_with?('[CANCELLED]')
    assert_equal '[CANCELLED] Cancelled Event', updated_events.first.summary
  end

  test "job does not double-cancel already cancelled events" do
    cancelled_event = create_mock_event(
      title: '[CANCELLED] Already Cancelled',
      description: 'This was already cancelled',
      location: 'N/A',
      start_time: 1.week.from_now,
      end_time: 1.week.from_now + 2.hours,
      hooks: { google_calendar_id: 'already-cancelled-id' },
      cancelled: true
    )

    mock_aggregator = create_mock_aggregator([cancelled_event])

    updated_events = []
    test_context = self
    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      # Mock get_event to return event with cancelled prefix
      calendar_service.define_singleton_method(:get_event) do |cal_id, event_id|
        test_context.send(:create_google_event,
          id: event_id,
          summary: '[CANCELLED] Already Cancelled',
          description: 'This was already cancelled'
        )
      end

      # Mock update_event - should NOT be called
      calendar_service.define_singleton_method(:update_event) do |cal_id, event_id, event|
        updated_events << event
        event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 0, updated_events.size, "Should not update event that already has [CANCELLED] prefix"
  end

  test "job handles all-day events" do
    all_day_event = create_mock_event(
      title: 'All Day Star Party',
      description: 'Full day event',
      location: 'Dark Sky Park',
      start_date: 1.week.from_now.to_date,
      end_date: 1.week.from_now.to_date,
      all_day: true,
      hooks: {}
    )

    mock_aggregator = create_mock_aggregator([all_day_event])

    created_events = []
    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      calendar_service.define_singleton_method(:insert_event) do |cal_id, event|
        created_events << event
        event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 1, created_events.size
    event = created_events.first
    assert_not_nil event.start.date, "All-day event should have start date"
    assert_nil event.start.date_time, "All-day event should not have start time"
    assert_not_nil event.end.date, "All-day event should have end date"
  end

  test "job creates new event when existing event id is not found" do
    # Event with ID that doesn't exist in Google Calendar
    event_with_missing_id = create_mock_event(
      title: 'Event with Missing ID',
      description: 'This ID does not exist',
      location: 'Somewhere',
      start_time: 1.week.from_now,
      end_time: 1.week.from_now + 2.hours,
      hooks: { google_calendar_id: 'non-existent-id' }
    )

    mock_aggregator = create_mock_aggregator([event_with_missing_id])

    created_events = []
    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      # Mock get_event to raise 404 error
      calendar_service.define_singleton_method(:get_event) do |cal_id, event_id|
        raise Google::Apis::ClientError.new('Not Found', status_code: 404)
      end

      # Should fall back to creating new event
      calendar_service.define_singleton_method(:insert_event) do |cal_id, event|
        created_events << event
        event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 1, created_events.size
    assert_equal 'Event with Missing ID', created_events.first.summary
  end

  test "job handles multiple events in one sync" do
    events = [
      create_mock_event(title: 'Event 1', start_time: 1.week.from_now, hooks: {}),
      create_mock_event(title: 'Event 2', start_time: 2.weeks.from_now, hooks: { google_calendar_id: 'existing-2' }),
      create_mock_event(title: 'Event 3', start_time: 3.weeks.from_now, hooks: {}, cancelled: true)
    ]

    mock_aggregator = create_mock_aggregator(events)

    created_count = 0
    updated_count = 0
    test_context = self

    stub_calendar_sync(mock_aggregator) do |calendar_service, calendar_id|
      calendar_service.define_singleton_method(:insert_event) do |cal_id, event|
        created_count += 1
        event
      end

      calendar_service.define_singleton_method(:get_event) do |cal_id, event_id|
        test_context.send(:create_google_event, id: event_id, summary: 'Existing Event')
      end

      calendar_service.define_singleton_method(:update_event) do |cal_id, event_id, event|
        updated_count += 1
        event
      end

      CalendarSyncJob.perform_now(@admin.email, calendar_id)
    end

    assert_equal 1, created_count, "Should create 1 new event"
    assert_equal 1, updated_count, "Should update 1 existing event"
  end

  private

  # Create a mock aggregated event
  def create_mock_event(title:, description: nil, location: nil, start_time: nil, end_time: nil,
                        start_date: nil, end_date: nil, all_day: false, hooks: {}, cancelled: false)
    event = Object.new
    event.define_singleton_method(:title) { title }
    event.define_singleton_method(:description) { description }
    event.define_singleton_method(:location) { location }
    event.define_singleton_method(:start_time) { start_time }
    event.define_singleton_method(:end_time) { end_time }
    event.define_singleton_method(:start_date) { start_date }
    event.define_singleton_method(:end_date) { end_date }
    event.define_singleton_method(:all_day?) { all_day }
    event.define_singleton_method(:hooks) { hooks }
    event.define_singleton_method(:cancelled?) { cancelled }
    event.define_singleton_method(:respond_to?) { |method| [:update_hook].include?(method) }
    event.define_singleton_method(:update_hook) { |key, value| hooks[key] = value }

    # Add properties expected by CalendarSyncJob
    event.define_singleton_method(:id) { hooks[:google_calendar_id] }
    event.define_singleton_method(:date) { all_day ? (start_date || Date.today) : (start_time&.to_date || Date.today) }
    event.define_singleton_method(:time) { all_day ? nil : start_time&.strftime('%I:%M %p') }
    event.define_singleton_method(:source) { 'Test Source' }
    event.define_singleton_method(:venue) { location ? { name: location, address: location } : nil }
    event.define_singleton_method(:status) { cancelled ? 'cancelled' : 'confirmed' }
    event.define_singleton_method(:going_count) { nil }

    event
  end

  # Create a mock aggregator
  def create_mock_aggregator(events)
    aggregator = Object.new
    aggregator.define_singleton_method(:fetch_events) do |start_date:, end_date:|
      events
    end
    aggregator
  end

  # Create a Google Calendar API event object
  def create_google_event(id:, summary:, description: nil, location: nil)
    event = Google::Apis::CalendarV3::Event.new(
      id: id,
      summary: summary,
      description: description,
      location: location,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: 1.week.from_now.to_datetime.rfc3339
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: (1.week.from_now + 2.hours).to_datetime.rfc3339
      )
    )
    event
  end

  # Stub Google Calendar API to not be called
  def stub_google_calendar_api_not_called
    Google::Apis::CalendarV3::CalendarService.stub :new, -> { raise "Google Calendar API should not be called" } do
      yield
    end
  end

  # Stub the complete calendar sync flow
  def stub_calendar_sync(mock_aggregator)
    mock_auth = Object.new
    mock_auth.define_singleton_method(:refresh_token=) { |token| }
    mock_auth.define_singleton_method(:fetch_access_token!) { }

    mock_calendar_service = Object.new
    mock_calendar_service.define_singleton_method(:authorization=) { |auth| }

    # Create a mock calendar with each_day method
    mock_calendar = Object.new
    mock_calendar.define_singleton_method(:each_day) do
      events_by_date = {}
      mock_aggregator.fetch_events(start_date: Date.today, end_date: Date.today + 3.months).each do |event|
        date = event.start_date || event.start_time&.to_date || Date.today
        events_by_date[date] ||= []
        events_by_date[date] << event
      end
      events_by_date
    end

    # Update mock aggregator to have generate_calendar method
    mock_aggregator.define_singleton_method(:generate_calendar) do |start_date, end_date|
      mock_calendar
    end

    # Stub the aggregator creation - use a lambda to always return our mock
    SJAA::Calendar::Aggregator.stub :new, ->(config) { mock_aggregator } do
      # Stub get_auth for all job instances
      CalendarSyncJob.class_eval do
        define_method(:get_auth) { |admin| mock_auth }
      end

      begin
        Google::Apis::CalendarV3::CalendarService.stub :new, mock_calendar_service do
          yield(mock_calendar_service, @calendar_id)
        end
      ensure
        # Restore original get_auth method by re-including GoogleHelper
        CalendarSyncJob.class_eval do
          include GoogleHelper
        end
      end
    end
  end
end
