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
docker container exec -it sjaa-memberships-app-1 bin/rails test                        # Run all tests
docker container exec -it sjaa-memberships-app-1 bin/rails test test/models/           # Run model tests only
docker container exec -it sjaa-memberships-app-1 bin/rails test test/controllers/      # Run controller tests only
docker container exec -it sjaa-memberships-app-1 bin/rails test test/system/           # Run system tests only
```

### Database Operations
```bash
# Database commands through Docker container
docker container exec -it sjaa-memberships-app-1 bin/rails db:migrate                  # Run pending migrations
docker container exec -it sjaa-memberships-app-1 bin/rails db:seed                     # Seed database with initial data
docker container exec -it sjaa-memberships-app-1 bin/rails db:reset                    # Drop, create, migrate, and seed database
docker container exec -it sjaa-memberships-app-1 bin/rails console                     # Start Rails console for data queries
```

### Custom Rake Tasks
```bash
# Custom rake tasks through Docker container
docker container exec -it sjaa-memberships-app-1 bin/rails generate_data                # Generate fake test data (100 people)
docker container exec -it sjaa-memberships-app-1 bin/rails patch PATCH_FILE=file.csv COMMIT=true  # Port data from SJAA database
docker container exec -it sjaa-memberships-app-1 bin/rails csv_compare CSV1=file1.csv CSV2=file2.csv  # Compare membership lists
```

### Docker Development
```bash
docker compose up                 # Start all services (app + postgres)
docker container exec -it sjaa-memberships-app-1 bin/rails test # Run tests in container

# Note: All Rails commands should be executed through the Docker container:
# docker container exec -it sjaa-memberships-app-1 bin/rails <command>
```

## Debugging Setup

### VS Code Remote Debugging with Docker

The application is configured for remote debugging using the `debug` gem with VS Code.

#### Prerequisites
- VS Code with Ruby LSP or Ruby extension installed
- Docker container running in development mode

#### Starting Debug Session

1. **Start the application with debugging enabled:**
```bash
# Option 1: Using the debug helper script
docker container exec -it sjaa-memberships-app-1 bin/rails-debug

# Option 2: Using rdbg directly
docker container exec -it sjaa-memberships-app-1 bundle exec rdbg --open --host 0.0.0.0 --port 1234 -- bin/rails server -b 0.0.0.0

# Option 3: Using environment variables (set in Dockerfile-dev)
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