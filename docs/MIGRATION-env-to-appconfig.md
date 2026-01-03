# Migration Guide: Environment Variables to AppConfig

This guide helps you migrate from environment variables to the new AppConfig database-backed configuration system.

## Overview

The following environment variables have been migrated to the `app_configs` table:

| Old Environment Variable | New AppConfig Key | Category | Encrypted |
|-------------------------|-------------------|----------|-----------|
| `SMTP_ADDRESS` | `smtp_address` | smtp | No |
| `SMTP_PORT` | `smtp_port` | smtp | No |
| `SMTP_DOMAIN` | `smtp_domain` | smtp | No |
| `SMTP_USER_NAME` | `smtp_user_name` | smtp | No |
| `SMTP_PASSWORD` | `smtp_password` | smtp | **Yes** |
| `PAYPAL_CLIENT_ID` | `paypal_client_id` | paypal | **Yes** |
| `PAYPAL_CLIENT_SECRET` | `paypal_client_secret` | paypal | **Yes** |
| `GOOGLE_WEB_CLIENT_BASE64` | `google_web_client_base64` | google | **Yes** |
| `GOOGLE_MEMBERS_GROUP` | `google_members_group` | google | No |
| `GOOGLE_REMOVE_GROUP` | `google_remove_group` | google | No |
| `SJAA_GOOGLE_API_KEY` | `google_api_key` | google | **Yes** |
| `SJAA_ALL_EVENTS_CALENDAR_ID` | `google_all_events_calendar_id` | google | No |
| `SJAA_MERGED_CALENDAR_ID` | `google_merged_calendar_id` | google | No |

## Migration Steps for Existing Deployments

### Step 1: Backup Your Environment Variables

Before migrating, document your current environment variables:

```bash
# On your server, save current values
echo "SMTP_ADDRESS=$SMTP_ADDRESS" >> ~/env-backup.txt
echo "SMTP_PORT=$SMTP_PORT" >> ~/env-backup.txt
echo "SMTP_DOMAIN=$SMTP_DOMAIN" >> ~/env-backup.txt
echo "SMTP_USER_NAME=$SMTP_USER_NAME" >> ~/env-backup.txt
# ... etc for all variables
```

### Step 2: Deploy the Migration

```bash
# Pull the latest code
git pull origin main

# Run migrations to create app_configs table
docker compose run --rm app bin/rails db:migrate

# The migration will create the table, but NOT populate it yet
```

### Step 3: Populate AppConfig with Existing Values

**Option A: Via Database Seeding (Recommended for first-time setup)**

If your environment variables are still set, the seed file will read them:

```bash
docker compose run --rm app bin/rails db:seed
```

This will create AppConfig records from your current environment variables.

**Option B: Via Rails Console (For existing deployments)**

```bash
docker compose run --rm app bin/rails console

# In the Rails console, manually create each config:
AppConfig.create!(key: 'smtp_address', value: 'smtp.gmail.com', category: 'smtp', description: 'SMTP server address')
AppConfig.create!(key: 'smtp_port', value: '587', category: 'smtp', description: 'SMTP server port')
# ... etc for each setting

# For encrypted values:
AppConfig.create!(key: 'smtp_password', value: 'your-password', category: 'smtp', description: 'SMTP password (encrypted)', encrypted: true)
```

**Option C: Via Web UI (After deployment)**

1. Log in as an admin with `permit` permission
2. Navigate to `/app_configs`
3. Click Edit next to each setting
4. Enter the values from your environment variables
5. Save each setting

### Step 4: Verify Configuration

Test that the application can read the new configuration:

```bash
docker compose run --rm app bin/rails console

# Test reading values
AppConfig.get('smtp_address')
# => "smtp.gmail.com"

AppConfig.smtp_settings
# => {:address=>"smtp.gmail.com", :port=>587, ...}

AppConfig.google_calendar_id
# => "your-calendar-id@group.calendar.google.com"
```

### Step 5: Test Application Functionality

1. **Test Email Sending**: Try sending a test email to verify SMTP settings
2. **Test PayPal**: Test a membership renewal to verify PayPal integration
3. **Test Google OAuth**: Verify Google authentication still works
4. **Test Calendar Sync**: Run a calendar sync job to verify calendar integration

### Step 6: Remove Environment Variables (Optional)

Once you've verified everything works, you can optionally remove the old environment variables from your `.env` file:

```bash
# Edit .env and remove these lines:
# SMTP_ADDRESS=
# SMTP_PORT=
# SMTP_DOMAIN=
# SMTP_USER_NAME=
# SMTP_PASSWORD=
# PAYPAL_CLIENT_ID=
# PAYPAL_CLIENT_SECRET=
# GOOGLE_WEB_CLIENT_BASE64=
# GOOGLE_MEMBERS_GROUP=
# GOOGLE_REMOVE_GROUP=
# SJAA_GOOGLE_API_KEY=
# SJAA_ALL_EVENTS_CALENDAR_ID=
```

**Keep these environment variables** (they're still used for deployment):
- `GITHUB_USERNAME`
- `GITHUB_TOKEN`
- `RAILS_ENV`
- `DATABASE_URL`
- Any other deployment-specific variables

## Rollback Plan

If you need to rollback to using environment variables:

1. Restore your `.env` file from the backup
2. Revert the code changes that use `AppConfig`
3. Redeploy the previous version

## Updating Configuration Post-Migration

After migration, update settings via the web UI:

1. Navigate to `/app_configs`
2. Find the setting you want to change
3. Click "Edit"
4. Enter the new value
5. Click "Update Configuration"

Changes take effect immediately (cached for 5 minutes).

## Troubleshooting

### "Missing Active Record encryption credential" Error

This error means Rails encryption is not configured. You have two options:

**Option 1: Configure Encryption (Recommended for Production)**

Generate encryption credentials:
```bash
docker compose run --rm app bin/rails db:encryption:init
```

Add the output to your `config/credentials.yml.enc`:
```bash
docker compose run --rm app bin/rails credentials:edit
```

**Option 2: Accept Plaintext Storage (Development/Test Only)**

The AppConfig model will automatically fall back to plaintext storage if encryption is not configured. This is acceptable for development but **not recommended for production**.

### Settings Not Taking Effect

Clear the configuration cache:
```bash
docker compose run --rm app bin/rails console

AppConfig.clear_all_cache
```

### Cannot Access /app_configs UI

Ensure your admin account has the `permit` permission:
```bash
docker compose run --rm app bin/rails console

admin = Admin.find_by(email: 'your-email@example.com')
admin.permissions << Permission.find_by(name: 'permit')
admin.save!
```

## Benefits of AppConfig

- **No Redeployment Required**: Change settings via web UI without redeploying
- **Audit Trail**: Track when configuration changes were made
- **Encryption**: Sensitive values are encrypted at rest
- **User-Friendly**: Non-technical users can update settings
- **Validation**: Settings are validated before being saved
- **Caching**: Frequently accessed values are cached for performance

## Questions?

Refer to the [App Configuration Guide](./app-configuration.md) for detailed usage information.
