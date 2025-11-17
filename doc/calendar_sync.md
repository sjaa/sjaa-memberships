# Calendar Sync Job

The `CalendarSyncJob` aggregates events from multiple calendar sources and syncs them to a master Google Calendar.

## Overview

This background job uses the `sjaa-ruby-calendar-aggregator` gem to:
1. Fetch events from configured sources (Google Calendar, Meetup.com, etc.)
2. Aggregate events for the next 3 months
3. Sync events to the SJAA All Events Google Calendar
4. Handle event creation, updates, and cancellations

## Setup

### 1. Configuration File

Copy the example configuration:
```bash
cp config/calendar_aggregator.yml.example config/calendar_aggregator.yml
```

Edit `config/calendar_aggregator.yml` to add your calendar sources:

```yaml
sources:
  google_calendars:
    - name: "SJAA Main Calendar"
      calendar_id: "your-calendar-id@group.calendar.google.com"

  meetup:
    - name: "SJAA Meetup Events"
      meetup_url: "https://www.meetup.com/sj-astronomy/events/"

settings:
  max_events_per_day: 100
  prioritize_timed_events: true
  debug: false
  time_zone: "America/Los_Angeles"
```

### 2. Environment Variables

Set the destination calendar ID:
```bash
SJAA_ALL_EVENTS_CALENDAR_ID=all-events@group.calendar.google.com
```

### 3. Admin Authentication

Ensure the admin user has authenticated with Google and has a valid refresh token stored in the database.

## Usage

### Run Immediately

```bash
# Using default calendar ID from environment
docker container exec -it sjaa-memberships-app-1 bin/rails runner \
  "CalendarSyncJob.perform_now('admin@sjaa.net')"

# Using specific calendar ID
docker container exec -it sjaa-memberships-app-1 bin/rails runner \
  "CalendarSyncJob.perform_now('admin@sjaa.net', 'custom-calendar@group.calendar.google.com')"
```

### Queue for Background Processing

```bash
docker container exec -it sjaa-memberships-app-1 bin/rails runner \
  "CalendarSyncJob.perform_later('admin@sjaa.net')"
```

### Schedule Recurring Sync

Add to your scheduler (e.g., cron, Whenever gem, or Solid Queue recurring jobs):

```ruby
# Run daily at 2 AM
CalendarSyncJob.perform_later('admin@sjaa.net')
```

## How It Works

### Event Processing Flow

1. **Fetch Events**: Generates calendars for the next 3 months using the aggregator
2. **Check Existing**: Looks for `google_calendar_id` in event metadata
3. **Sync Decision**:
   - **Cancelled Event**: Adds `[CANCELLED]` prefix to title (if not already present)
   - **Existing Event**: Updates event details in Google Calendar
   - **New Event**: Creates new event in Google Calendar

### Event Metadata

The job stores Google Calendar event IDs in the aggregator event's metadata:
```ruby
event.metadata[:google_calendar_id] = 'abc123...'
```

This allows the job to:
- Update events instead of creating duplicates
- Mark events as cancelled without deleting them
- Track which events have been synced

### Event Properties Synced

- **Title**: Event name
- **Description**: Combines event description, source, venue, attendance count
- **Location**: Venue name or address
- **Start/End Time**: Handles both timed and all-day events
- **Status**: Cancelled events are marked with prefix

### Error Handling

- Invalid admin or missing refresh token: Job exits early
- Event not found (404): Falls back to creating new event
- API errors: Logged with full backtrace, job continues with remaining events
- Configuration file missing: Uses default configuration

## Logging

The job provides comprehensive logging:

```
[CalendarSyncJob] Fetching aggregated events from 2025-11-15 to 2026-02-15
[CalendarSyncJob] Found 45 events to sync
[CalendarSyncJob] Created event: Star Party at Houge Park (ID: abc123...)
[CalendarSyncJob] Updated event: Monthly Meeting
[CalendarSyncJob] Marked event as cancelled: [CANCELLED] Cancelled Event
[CalendarSyncJob] Sync complete: {:created=>12, :updated=>28, :cancelled=>3, :errors=>2}
```

## Troubleshooting

### No events synced
- Check configuration file exists and has valid sources
- Verify calendar sources are accessible
- Check date range (only syncs next 3 months)

### Authentication errors
- Ensure admin has valid refresh token
- Verify `GOOGLE_WEB_CLIENT_BASE64` environment variable is set
- Check admin email matches database record

### Duplicate events
- Events without metadata will be created as new
- Ensure aggregator preserves metadata between runs
- Consider adding event matching logic (title + date)

### Events not updating
- Verify `google_calendar_id` is stored in event metadata
- Check calendar permissions for the admin account
- Review logs for 404 errors (event no longer exists)

## Testing

Run the test suite:
```bash
docker container exec -it sjaa-memberships-app-1 bin/rails test test/jobs/calendar_sync_job_test.rb
```

The tests cover:
- Admin validation
- Event creation, updates, and cancellations
- All-day vs. timed events
- Error handling
- Multiple event processing

## Future Enhancements

Potential improvements:
- Event deduplication based on title/date matching
- Persistent metadata storage for event mappings
- Support for recurring events
- Event deletion for removed source events
- Webhook-based real-time syncing
- Multi-calendar destination support
