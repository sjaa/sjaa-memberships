# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require_relative('./sjaa_port')
include SjaaPort

# Application configuration
# These values should be updated with actual credentials after deployment
puts "Creating application configuration..."

# SMTP Email Settings
AppConfig.find_or_create_by!(key: 'smtp_address') do |c|
  c.value = ENV.fetch('SMTP_ADDRESS', 'smtp.gmail.com')
  c.category = 'smtp'
  c.description = 'SMTP server address'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'smtp_port') do |c|
  c.value = ENV.fetch('SMTP_PORT', '587')
  c.category = 'smtp'
  c.description = 'SMTP server port'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'smtp_domain') do |c|
  c.value = ENV.fetch('SMTP_DOMAIN', 'sjaa.net')
  c.category = 'smtp'
  c.description = 'SMTP domain'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'smtp_user_name') do |c|
  c.value = ENV.fetch('SMTP_USER_NAME', '')
  c.category = 'smtp'
  c.description = 'SMTP username'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'smtp_password') do |c|
  c.value = ENV.fetch('SMTP_PASSWORD', '')
  c.category = 'smtp'
  c.description = 'SMTP password (encrypted)'
  c.encrypted = true
end

# PayPal Settings
AppConfig.find_or_create_by!(key: 'paypal_client_id') do |c|
  c.value = ENV.fetch('PAYPAL_CLIENT_ID', '')
  c.category = 'paypal'
  c.description = 'PayPal client ID (encrypted)'
  c.encrypted = true
end

AppConfig.find_or_create_by!(key: 'paypal_client_secret') do |c|
  c.value = ENV.fetch('PAYPAL_CLIENT_SECRET', '')
  c.category = 'paypal'
  c.description = 'PayPal client secret (encrypted)'
  c.encrypted = true
end

# Google API Settings
AppConfig.find_or_create_by!(key: 'google_web_client_base64') do |c|
  c.value = ENV.fetch('GOOGLE_WEB_CLIENT_BASE64', '')
  c.category = 'google'
  c.description = 'Base64 encoded Google OAuth client configuration (encrypted)'
  c.encrypted = true
end

AppConfig.find_or_create_by!(key: 'google_members_group') do |c|
  c.value = ENV.fetch('GOOGLE_MEMBERS_GROUP', 'membership-app-test-group@sjaa.net')
  c.category = 'google'
  c.description = 'Google Groups email for active members'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'google_remove_group') do |c|
  c.value = ENV.fetch('GOOGLE_REMOVE_GROUP', 'expired-members@sjaa.net')
  c.category = 'google'
  c.description = 'Google Groups email for expired members'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'google_api_key') do |c|
  c.value = ENV.fetch('SJAA_GOOGLE_API_KEY', '')
  c.category = 'google'
  c.description = 'Google API key for calendar access (encrypted)'
  c.encrypted = true
end

AppConfig.find_or_create_by!(key: 'google_all_events_calendar_id') do |c|
  c.value = ENV.fetch('SJAA_ALL_EVENTS_CALENDAR_ID', '')
  c.category = 'google'
  c.description = 'Google Calendar ID for SJAA All Events calendar'
  c.encrypted = false
end

AppConfig.find_or_create_by!(key: 'google_merged_calendar_id') do |c|
  c.value = ENV.fetch('SJAA_MERGED_CALENDAR_ID', '')
  c.category = 'google'
  c.description = 'Google Calendar ID for SJAA Merged calendar (legacy)'
  c.encrypted = false
end

# Membership Settings
AppConfig.find_or_create_by!(key: 'membership_renewal_threshold_months') do |c|
  c.value = ENV.fetch('MEMBERSHIP_RENEWAL_THRESHOLD_MONTHS', '2')
  c.category = 'membership'
  c.description = 'Number of months before expiration to show renewal reminders and mark memberships as renewable'
  c.encrypted = false
end

puts "Application configuration created successfully!"
