# Application Configuration System

The SJAA Membership application uses a database-backed configuration system for managing application settings. This allows runtime configuration changes without redeploying the application.

## Overview

Previously, application settings were stored as environment variables. These have been migrated to the `app_configs` table, which provides:

- **Database storage**: Configuration persists in the database
- **Web UI management**: Admins can update settings through the web interface
- **Encryption**: Sensitive values (passwords, API keys) are encrypted at rest
- **Caching**: Frequently accessed values are cached for performance
- **Audit trail**: Changes are tracked through standard Rails timestamps

## Configuration Categories

### SMTP Email Settings
- `smtp_address`: Mail server address (e.g., smtp.gmail.com)
- `smtp_port`: Mail server port (e.g., 587)
- `smtp_domain`: Email domain (e.g., sjaa.net)
- `smtp_user_name`: SMTP username
- `smtp_password`: SMTP password (encrypted)

### PayPal Settings
- `paypal_client_id`: PayPal API client ID (encrypted)
- `paypal_client_secret`: PayPal API secret (encrypted)

### Google API Settings
- `google_web_client_base64`: Base64-encoded Google OAuth client configuration (encrypted)
- `google_members_group`: Email address of the Google Group for active members
- `google_remove_group`: Email address of the Google Group for expired members
- `google_api_key`: Google API key for calendar access (encrypted)
- `google_all_events_calendar_id`: Google Calendar ID for SJAA All Events calendar
- `google_merged_calendar_id`: Google Calendar ID for SJAA Merged calendar (legacy)

## Managing Configuration

### Web UI (Recommended)

1. Log in as an admin with `permit` permission
2. Navigate to **Data** → **App Configuration**
3. View all settings organized by category
4. Click **Edit** next to any setting to change its value
5. For encrypted fields, leave blank to keep the existing value

**First-time Setup:**
If no configuration exists, you'll see a button to "Initialize Configuration from Environment Variables". This will:
- Create all 13 configuration entries
- Populate values from environment variables (if set)
- Use sensible defaults for values not in environment variables
- This is equivalent to running `rails db:seed` but accessible via the web UI

### Programmatic Access

```ruby
# Get a configuration value
AppConfig.get('smtp_address')

# Get with a required check (raises error if not found)
AppConfig.get('smtp_address', required: true)

# Set a configuration value
AppConfig.set('smtp_port', '587', category: 'smtp', description: 'SMTP port')

# Get all settings for a category
AppConfig.for_category('smtp')

# Get SMTP settings as a hash
AppConfig.smtp_settings
```

### Console Access

```bash
docker compose run --rm app bin/rails console

# In the Rails console:
AppConfig.get('smtp_address')
AppConfig.set('smtp_address', 'smtp.gmail.com')
```

## Initial Setup

### First Time Installation

1. Run migrations to create the `app_configs` table:
   ```bash
   docker compose run --rm app bin/rails db:migrate
   ```

2. (Optional) Set environment variables in `.env` with initial values:
   ```
   SMTP_ADDRESS=smtp.gmail.com
   SMTP_PORT=587
   # ... etc
   ```

3. Run seeds to populate the configuration table:
   ```bash
   docker compose run --rm app bin/rails db:seed
   ```
   This will create configuration records using values from environment variables or sensible defaults.

4. Update settings via the web UI at `/app_configs`

### Migrating from Environment Variables

If you're upgrading from a version that used environment variables:

1. Your existing environment variables will be read during `db:seed`
2. After seeding, all settings are stored in the database
3. You can then remove the environment variables from `.env` (except for deployment-related variables like `GITHUB_USERNAME` and `GITHUB_TOKEN`)
4. Future configuration changes should be made via the web UI

## Security Considerations

### Encrypted Fields

The following fields are automatically encrypted when stored:
- `smtp_password`
- `paypal_client_id`
- `paypal_client_secret`
- `google_web_client_base64`
- `google_api_key`

Encryption uses Rails 7+ `encrypts` feature with the application's credentials.

### Permissions

Only admins with the `permit` permission can:
- View the configuration interface
- Edit configuration values

Regular admins with `read` or `write` permissions cannot access configuration settings.

### Master Key

Encrypted values require the Rails master key to decrypt. Ensure `config/master.key` or `RAILS_MASTER_KEY` environment variable is properly configured in production.

## Caching

Configuration values are cached for 5 minutes to reduce database queries. The cache is automatically cleared when:
- A configuration value is updated
- A configuration value is deleted
- `AppConfig.clear_cache(key)` is called manually

## Environment Variables vs Database Configuration

### Use Database Configuration (AppConfig) for:
- Application functionality settings (SMTP, PayPal, Google)
- Values that may need to change without redeployment
- Sensitive data that should be encrypted

### Use Environment Variables for:
- Deployment and infrastructure settings
- Values that differ between environments (development, staging, production)
- Settings needed before the database is available
- Examples: `GITHUB_USERNAME`, `GITHUB_TOKEN`, `RAILS_ENV`, `DATABASE_URL`

**Note:** `SJAA_ALL_EVENTS_CALENDAR_ID` and `SJAA_MERGED_CALENDAR_ID` were previously environment variables but have been migrated to AppConfig for easier management.

## Troubleshooting

### Configuration not taking effect

Clear the cache:
```ruby
AppConfig.clear_cache('smtp_address')
# Or clear all caches
AppConfig.clear_all_cache
```

### Encrypted values showing as blank

This is expected behavior for security. Encrypted values display as `[Encrypted - Set]` in the UI. To update, enter a new value in the edit form.

### SMTP settings not loading

Check the initializer log:
```bash
docker compose logs app | grep "SMTP settings"
```

Expected output: `SMTP settings loaded from AppConfig`

If you see `Skipping SMTP configuration`, the database may not be ready or settings are missing.

### Database migration issues

If the app_configs table doesn't exist:
```bash
docker compose run --rm app bin/rails db:migrate
```

## API Reference

### Class Methods

- `AppConfig.get(key, required: false)` - Retrieve a configuration value
- `AppConfig.set(key, value, category: nil, description: nil, encrypted: false)` - Set a configuration value
- `AppConfig.for_category(category)` - Get all configs in a category
- `AppConfig.smtp_settings` - Get SMTP settings as a hash
- `AppConfig.paypal_client_id` - Get PayPal client ID
- `AppConfig.paypal_client_secret` - Get PayPal client secret
- `AppConfig.google_web_client_base64` - Get Google OAuth config
- `AppConfig.google_members_group` - Get Google members group email
- `AppConfig.google_remove_group` - Get Google remove group email
- `AppConfig.google_api_key` - Get Google API key
- `AppConfig.google_all_events_calendar_id` - Get Google Calendar ID for SJAA All Events
- `AppConfig.google_merged_calendar_id` - Get Google Calendar ID for SJAA Merged calendar (legacy)
- `AppConfig.google_calendar_id` - Get calendar ID (prefers all_events, falls back to merged)
- `AppConfig.clear_cache(key)` - Clear cache for a specific key
- `AppConfig.clear_all_cache` - Clear all configuration caches

### Instance Methods

- `encrypted?` - Check if the value is encrypted
