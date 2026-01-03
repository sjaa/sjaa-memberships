class AppConfigsController < ApplicationController
  def index
    authorize AppConfig
    @configs_by_category = AppConfig.all.group_by(&:category).sort_by { |k, _| k }
    @configs_empty = AppConfig.count == 0
  end

  def edit
    @config = AppConfig.find(params[:id])
    authorize @config
  end

  def update
    @config = AppConfig.find(params[:id])
    authorize @config

    if @config.update(config_params)
      flash[:success] = "Configuration updated successfully"
      redirect_to app_configs_path
    else
      flash.now[:alert] = "Failed to update configuration"
      render :edit
    end
  end

  def seed_from_env
    authorize AppConfig
    begin
      seed_all_configs
      flash[:success] = "Configuration settings have been seeded successfully!"
    rescue => e
      flash[:alert] = "Error seeding configurations: #{e.message}"
    end
    redirect_to app_configs_path
  end

  private

  def config_params
    params.require(:app_config).permit(:value)
  end

  def seed_all_configs
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
  end
end
