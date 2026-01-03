# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ruby on Rails 7.1+ membership management application for SJAA (San Jose Astronomical Association). The app manages:

- Member database with contact information, interests, and equipment
- Membership renewals and donation tracking
- Admin authentication with role-based permissions (read/write/permit)
- Email notifications and PayPal payment integration
- RESTful API with bearer token authentication
- Integration with Google services (Admin Directory, Groups, Calendar, Sheets)

## Common Commands

### Development Setup
```bash
bundle install                    # Install Ruby dependencies
rails db:setup                   # Set up database schema and seed data
rails server                     # Start development server (port 3000)
```

### Testing
```bash
# Run tests through Docker container
docker compose run --rm app bin/rails test:all                    # Run all tests
docker compose run --rm app bin/rails test test/models/           # Run model tests only
docker compose run --rm app bin/rails test test/controllers/      # Run controller tests only
docker compose run --rm app bin/rails test test/system/           # Run system tests only
```

### Database Operations
```bash
# Database commands through Docker container
docker compose run --rm app bin/rails db:migrate                  # Run pending migrations
docker compose run --rm app bin/rails db:seed                     # Seed database with initial data
docker compose run --rm app bin/rails db:reset                    # Drop, create, migrate, and seed database
docker compose run --rm app env RUBYOPT="-W0" bin/rails console  # Start Rails console (suppresses rdoc warnings)
```

### Custom Rake Tasks
```bash
# Custom rake tasks through Docker container
docker compose run --rm app bin/rails generate_data                # Generate fake test data (100 people)
docker compose run --rm app bin/rails patch PATCH_FILE=file.csv COMMIT=true  # Port data from SJAA database
docker compose run --rm app bin/rails csv_compare CSV1=file1.csv CSV2=file2.csv  # Compare membership lists

# People merging tasks
docker compose run --rm app bin/rails merge_people KEEPER=123 DUPLICATE=456  # Preview merging two people (dry-run)
docker compose run --rm app bin/rails merge_people KEEPER=123 DUPLICATE=456 COMMIT=true  # Merge two people by ID
docker compose run --rm app bin/rails merge_duplicate_emails  # Preview merging people with duplicate emails (dry-run)
docker compose run --rm app bin/rails merge_duplicate_emails COMMIT=true  # Find and merge people with duplicate emails
```

### Background Jobs
```bash
# Calendar sync job - syncs events from aggregator to Google Calendar
docker compose run --rm app bin/rails runner "CalendarSyncJob.perform_now('vp@sjaa.net')"
docker compose run --rm app bin/rails runner "CalendarSyncJob.perform_now('vp@sjaa.net', 'custom-calendar@group.calendar.google.com')"

# Google Group sync job - syncs a Google Group with the membership database
# Basic usage (syncs members@sjaa.net with active members)
docker compose run --rm app bin/rails runner "GoogleGroupSyncJob.perform_now('vp@sjaa.net', 'members@sjaa.net')"

# With custom options
docker compose run --rm app bin/rails runner "GoogleGroupSyncJob.perform_now('vp@sjaa.net', 'observers@sjaa.net', group_id: 42, use_remove_group: true, remove_group: 'expired-members@sjaa.net', clear_remove_group: true, add_only: false)"

# Preview mode - populate remove group without modifying primary group (useful for warning members)
docker compose run --rm app bin/rails runner "GoogleGroupSyncJob.perform_now('vp@sjaa.net', 'members@sjaa.net', use_remove_group: true, remove_group: 'expired-members@sjaa.net', preview_only: true)"

# Queue jobs for later processing
docker compose run --rm app bin/rails runner "CalendarSyncJob.perform_later('vp@sjaa.net')"
docker compose run --rm app bin/rails runner "GoogleGroupSyncJob.perform_later('vp@sjaa.net', 'members@sjaa.net')"

# Process queued jobs with custom worker (auto-stops when queue is empty)
docker compose run --rm app bin/rails runner lib/solid_queue_simple_worker.rb

# Process specific queues
docker compose run --rm app bin/rails runner "lib/solid_queue_simple_worker.rb -q default"

# With debug logging
docker compose run --rm app bin/rails runner "lib/solid_queue_simple_worker.rb -d"

# Volunteer opportunity matching job - emails volunteers about matching opportunities
docker compose run --rm app bin/rails runner "VolunteerOpportunityMatchJob.perform_now"

# Queue for later processing
docker compose run --rm app bin/rails runner "VolunteerOpportunityMatchJob.perform_later"

# Clear all queued jobs without running them
docker compose run --rm app bin/rails runner "SolidQueue::Job.delete_all"

# Clear only pending jobs
docker compose run --rm app bin/rails runner "SolidQueue::Job.where(finished_at: nil).delete_all"

# Run jobs WITH notifications (sends real-time notifications to the specified user)
docker compose run --rm app bin/rails runner "GoogleGroupSyncJob.perform_now_with_notifications('vp@sjaa.net', 'vp@sjaa.net', 'members@sjaa.net')"
docker compose run --rm app bin/rails runner "CalendarSyncJob.perform_later_with_notifications('admin@sjaa.net', 'admin@sjaa.net')"
```

### Notifications
```bash
# Notification management tasks
docker compose run --rm app bin/rails notifications:cleanup            # Clean notifications older than 10 days
docker compose run --rm app bin/rails notifications:cleanup[30]        # Clean notifications older than 30 days
docker compose run --rm app bin/rails notifications:cleanup_read       # Delete all read notifications
docker compose run --rm app bin/rails notifications:stats              # Show notification statistics
```

### Docker Development
```bash
docker compose up                 # Start all services (app + postgres)
docker compose run --rm app bin/rails test # Run tests in container

# Note: All Rails commands should be executed through the Docker container:
# docker compose run --rm app bin/rails <command>
```

### Updating Gemfile and Gemfile.lock
When you update `Gemfile` (add/remove/update gems), follow these steps to update `Gemfile.lock`:

```bash
# 1. Rebuild the Docker image (this installs gems and updates Gemfile.lock inside the image)
docker compose build app

# 2. Extract the updated Gemfile.lock from the built image to your local filesystem
docker create --name temp ruby:latest && docker cp temp:/rails/Gemfile.lock ./ && docker rm temp

# 3. Restart containers with the updated configuration
docker compose up -d
```

**Why this is necessary**: The project uses a bind mount (`./:/rails`) which overlays your local directory onto the container's `/rails` directory at runtime. This means the `Gemfile.lock` updated during the Docker build gets replaced by your local version when the container starts. Extracting it ensures your local copy stays in sync with what was installed in the image.

## Debugging Setup

### VS Code Remote Debugging with Docker

The application is configured for remote debugging using the `debug` gem with VS Code.

#### Prerequisites
- VS Code with Ruby LSP or Ruby extension installed
- Docker container running in development mode

#### Starting Debug Session

1. **Start the application with debugging enabled:**
```bash
docker compose up  # Debug server auto-starts on port 1234
```

2. **In VS Code:**
   - Set breakpoints in your Ruby code by clicking in the gutter
   - Open the Run and Debug view (Ctrl+Shift+D / Cmd+Shift+D)
   - Select one of the debug configurations:
     - "Attach to Rails (Docker)" - Primary option
     - "Debug Rails (Docker) - Alternative" - Fallback option
     - "Connect to rdbg (Docker)" - Direct rdbg connection
   - Click the green play button or press F5

3. **Debugging Commands:**
   - `debugger` - Add this line in your code to create a breakpoint
   - Step through code using VS Code's debug controls
   - Inspect variables in the debug console
   - Use the debug terminal for REPL interaction

#### Debug Configuration
- Debug server runs on `localhost:1234`
- Remote workspace root: `/rails`
- Local workspace root: your project directory

#### Troubleshooting
- Ensure port 1234 is not in use by other processes
- Check Docker logs: `docker compose logs app`
- Verify debug gem is installed: `docker container exec sjaa-memberships-app-1 gem list debug`
- Restart containers if debug connection fails: `docker compose restart`

## Architecture

### Key Models and Relationships
- **Person**: Central model for members with contacts, memberships, donations
- **Admin**: Authentication model with role-based permissions via Pundit
- **Membership**: Tracks membership periods with start dates and term lengths
- **Donation**: Financial contributions with amounts and notes
- **Contact**: Email/address/phone information (multiple per person)
- **Equipment**: Member-owned astronomical instruments
- **Group**: Member categories (e.g., "Observers List", "Board Members")

### Core Controllers
- **PeopleController**: CRUD operations for members
- **AdminsController**: Admin user management
- **MembershipsController**: Membership renewal and tracking
- **ApiKeysController**: API token management
- **GoogleController**: Google Workspace integration

### Authorization
Uses Pundit for role-based access control with three permission levels:
- `read`: View member data
- `write`: Edit member data  
- `permit`: Manage admin permissions

### API Usage Examples
```ruby
# Find member by email
Person.joins(:contacts).where(contact: {email: 'user@example.com'}).first

# Check membership status
Person.find_by(last_name: 'Smith').status.name

# Find expired memberships
Person.lapsed_members(status: 'member')

# Get membership expiration date
membership = Person.find(42).memberships.order(start: :desc).first
expiration = membership.start + membership.term_months.months
```

### Background Jobs
Uses Solid Queue for background job processing:
- Email notifications (welcome emails, renewal reminders)
- Google Workspace synchronization
- PayPal payment processing
- Calendar event synchronization (CalendarSyncJob)

#### Calendar Sync Job
The `CalendarSyncJob` syncs events from multiple sources (Google Calendar, Meetup.com) to the SJAA All Events calendar.

**Configuration:**
1. Copy `config/calendar_aggregator.yml.example` to `config/calendar_aggregator.yml`
2. Update the configuration with your calendar sources
3. Configure the calendar ID via the admin UI at `/app_configs` (key: `google_all_events_calendar_id` or `google_merged_calendar_id`) or set it during database seeding with `SJAA_ALL_EVENTS_CALENDAR_ID` or `SJAA_MERGED_CALENDAR_ID` environment variable

**Features:**
- Fetches 3 months of events from configured sources
- Creates new events in Google Calendar
- Updates existing events based on metadata
- Marks cancelled events with `[CANCELLED]` prefix
- Supports both timed and all-day events
- Comprehensive logging and error handling

**Requirements:**
- Admin account with valid Google Calendar refresh token
- Calendar aggregator configuration file (optional, uses defaults if not present)
- Google Calendar ID configured in app settings (`google_all_events_calendar_id` or `google_merged_calendar_id`)

### Real-Time Notification System
The application uses Action Cable for real-time WebSocket notifications to both admins and members.

#### Notification Categories
- **job_status**: Background job lifecycle events (queued, started, completed, failed)
- **membership**: Membership-related notifications (renewal reminders, expiration, activation)
- **mentorship**: Mentorship contact requests
- **admin_alert**: Admin-specific alerts (new signups, sync errors, import completion)
- **system**: General system notifications

#### Notification Priorities
- **urgent**: Requires immediate attention (membership expired)
- **high**: Important but not critical (job failures, approaching renewals)
- **normal**: Standard notifications (job completions, mentor contacts)
- **low**: Informational (job queued, job started)

#### Key Components
- **Notification Model** ([app/models/notification.rb](app/models/notification.rb)): Polymorphic associations to Person and Admin
- **NotificationChannel** ([app/channels/notification_channel.rb](app/channels/notification_channel.rb)): User-specific WebSocket channel
- **NotificationBroadcaster** ([app/services/notification_broadcaster.rb](app/services/notification_broadcaster.rb)): Service for creating and broadcasting notifications
- **NotificationsController** ([app/controllers/notifications_controller.rb](app/controllers/notifications_controller.rb)): REST API for notification management

#### Using Notifications with Background Jobs
Jobs can opt-in to automatic notifications by setting `enable_notifications = true`:

```ruby
class MyJob < ApplicationJob
  self.enable_notifications = true

  def perform(*args)
    # Job automatically sends notifications on queue, start, complete, and failure
  end
end

# Trigger with notifications - user can be Person, Admin, email, or ID
MyJob.perform_later_with_notifications(current_user, arg1, arg2)     # From controller
MyJob.perform_now_with_notifications('admin@sjaa.net', arg1, arg2)  # From command line
MyJob.perform_now_with_notifications(123, arg1, arg2)               # Using ID
```

**User Parameter Formats:**
- `Person` or `Admin` object (from controller with `current_user`)
- Email string: `'admin@sjaa.net'` or `'member@example.com'` (looks up both Admin and Person)
- Integer ID: `123` (checks Admin table first, then Person table)


#### Manual Notification Broadcasting
```ruby
# Notify about membership events
NotificationBroadcaster.membership_renewal_reminder(person, 7)
NotificationBroadcaster.membership_activated(person, membership)

# Notify mentors of contact requests
NotificationBroadcaster.mentor_contact_received(mentor, requester_name, message)

# Admin alerts
NotificationBroadcaster.google_sync_error(admin, error_message)
NotificationBroadcaster.csv_import_completed(admin, imported_count, errors_count)

# System messages
NotificationBroadcaster.system_message(user, "Your profile is incomplete", priority: 'normal')
```

#### Notification Lifecycle
1. Notification created in database with recipient (Person or Admin)
2. After creation, notification automatically broadcasts via Action Cable
3. Connected users receive real-time toast popup and bell badge update
4. Clicking notification marks it as read
5. Notifications auto-delete after 10 days (configurable via rake task)

#### User Interface
- **Bell Icon**: Navbar notification bell with unread count badge
- **Dropdown**: Recent unread notifications with category icons and timestamps
- **Toast Popups**: Auto-dismissing alerts for new notifications
- **Priority Styling**: Color-coded badges based on notification priority

### Email System
Configured for SMTP delivery using Google's servers with app passwords. Development can use Mailtrap for testing.

## Development Notes

### Ruby Version
Requires Ruby 3.4.1 (managed via RVM or similar)

### Database
Uses PostgreSQL in all environments. Schema includes comprehensive member data with proper referential integrity.

### Assets
Uses Propshaft asset pipeline with Stimulus/Turbo for interactive features.

### Testing
Comprehensive test suite using Rails built-in testing with Capybara for system tests.