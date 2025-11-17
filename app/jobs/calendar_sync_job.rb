class CalendarSyncJob < ApplicationJob
  queue_as :default
  
  # CalendarSyncJob.perform_later(admin_email, calendar_id)
  #   admin_email - Email of admin with valid refresh token for calendar access
  #   calendar_id - Google Calendar ID to update (defaults to ENV variable)
  #
  # This job fetches 3 months of events from the SJAA calendar aggregator
  # and syncs them to a Google Calendar, creating new events, updating existing
  # ones, and marking cancelled events.
  def perform(admin_email, calendar_id = nil)
    require 'sjaa/calendar_aggregator'
    
    calendar_id ||= ENV.fetch('SJAA_ALL_EVENTS_CALENDAR_ID')
    admin = Admin.find_by(email: admin_email)
    
    # Validate admin has refresh token
    if admin&.refresh_token.nil?
      Rails.logger.error "[CalendarSyncJob] Admin #{admin_email} not found or missing refresh token"
      return
    end
    
    # Get Google Calendar service with auth
    auth = get_google_auth(admin)
    calendar_service = Google::Apis::CalendarV3::CalendarService.new
    calendar_service.authorization = auth
    
    # Fetch events from aggregator for next 3 months
    today = Date.today
    end_date = today + 3.months
    
    Rails.logger.info "[CalendarSyncJob] Fetching aggregated events from #{today} to #{end_date}"
    
    # Create a simple configuration programmatically
    config = SJAA::Calendar::Configuration.new
    
    # Add a Google Calendar source (you'll need to provide a real API key and calendar ID)
    config.add_google_calendar(
    name: "SJAA Main Calendar",
    calendar_id: "c_4779ddc46fda914aaa8045b916044a480265c50bb4642df9420923706837a63e@group.calendar.google.com"
    )
    
    # Add a Meetup source
    config.add_meetup_source(
    name: "SJAA Meetup Events",
    meetup_url: "https://www.meetup.com/sj-astronomy/events/"
    )
    
    # Add moon phases
    config.add_moon_phase_source
    
    # Configure settings
    config.max_events_per_day = 3
    config.prioritize_timed_events = true
    config.debug = true
    config.google_api_key = ENV['SJAA_GOOGLE_API_KEY']

    # Create aggregator
    aggregator = SJAA::Calendar::Aggregator.new(config)
    
    # Collect all events from the next 3 months
    aggregated_events = []
    
    calendar = aggregator.generate_calendar(today, end_date)
    aggregated_events = calendar.each_day.select{|date, events| date <= end_date  && date >= today}.flat_map { |date, events| events }

    Rails.logger.info "[CalendarSyncJob] Found #{aggregated_events.size} events to sync"
    
    # Track sync statistics
    stats = { created: 0, updated: 0, cancelled: 0, errors: 0 }
    
    # Process each aggregated event
    aggregated_events.each do |agg_event|
      begin
        sync_event(calendar_service, calendar_id, agg_event, stats)
      rescue => e
        stats[:errors] += 1
        Rails.logger.error "[CalendarSyncJob] Error syncing event '#{agg_event.title}': #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
      end
    end
    
    Rails.logger.info "[CalendarSyncJob] Sync complete: #{stats.inspect}"
  end
  
  private
  
  # Get Google OAuth2 authorization from admin's refresh token
  def get_google_auth(admin)
    require 'google/api_client/client_secrets'
    
    # Load client secrets from environment
    cshash = JSON.parse(Base64.decode64(ENV['GOOGLE_WEB_CLIENT_BASE64']))
    client_secrets = Google::APIClient::ClientSecrets.new(cshash)
    
    # Create auth object with refresh token
    auth = client_secrets.to_authorization
    auth.refresh_token = admin.refresh_token
    auth.fetch_access_token!
    
    auth
  end
  
  # Sync a single event to Google Calendar
  def sync_event(calendar_service, calendar_id, agg_event, stats)
    # Check if event already exists in Google Calendar via metadata
    existing_event_id = agg_event.metadata&.dig(:google_calendar_id)
    
    # Check if event is cancelled based on status
    if agg_event.status&.downcase&.include?('cancelled')
      handle_cancelled_event(calendar_service, calendar_id, agg_event, existing_event_id, stats)
    elsif existing_event_id
      update_existing_event(calendar_service, calendar_id, agg_event, existing_event_id, stats)
    else
      create_new_event(calendar_service, calendar_id, agg_event, stats)
    end
  end
  
  # Handle cancelled events
  def handle_cancelled_event(calendar_service, calendar_id, agg_event, existing_event_id, stats)
    return unless existing_event_id
    
    # Fetch existing event and update title to reflect cancellation
    event = calendar_service.get_event(calendar_id, existing_event_id)
    
    # Update title with CANCELLED prefix if not already present
    unless event.summary.start_with?('[CANCELLED]')
      event.summary = "[CANCELLED] #{event.summary}"
      calendar_service.update_event(calendar_id, existing_event_id, event)
      stats[:cancelled] += 1
      Rails.logger.info "[CalendarSyncJob] Marked event as cancelled: #{event.summary}"
    end
  rescue Google::Apis::ClientError => e
    if e.status_code == 404
      Rails.logger.warn "[CalendarSyncJob] Event #{existing_event_id} not found in calendar"
    else
      raise
    end
  end
  
  # Update an existing Google Calendar event
  def update_existing_event(calendar_service, calendar_id, agg_event, event_id, stats)
    # Fetch the existing event
    event = calendar_service.get_event(calendar_id, event_id)
    
    # Update event properties from aggregated event
    event.summary = agg_event.title
    event.description = build_event_description(agg_event)
    event.location = agg_event.venue&.dig(:name) || agg_event.location
    
    # Update start and end times
    if agg_event.all_day?
      event.start = Google::Apis::CalendarV3::EventDateTime.new(
      date: agg_event.date.to_s
      )
      event.end = Google::Apis::CalendarV3::EventDateTime.new(
      date: agg_event.date.to_s
      )
    else
      start_time = parse_event_time(agg_event)
      end_time = start_time + 2.hours # Default 2 hour duration
      
      event.start = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: start_time.to_datetime.rfc3339,
      time_zone: 'America/Los_Angeles'
      )
      event.end = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: end_time.to_datetime.rfc3339,
      time_zone: 'America/Los_Angeles'
      )
    end
    
    calendar_service.update_event(calendar_id, event_id, event)
    stats[:updated] += 1
    Rails.logger.info "[CalendarSyncJob] Updated event: #{event.summary}"
  rescue Google::Apis::ClientError => e
    if e.status_code == 404
      # Event no longer exists, create it instead
      Rails.logger.warn "[CalendarSyncJob] Event #{event_id} not found, creating new event"
      create_new_event(calendar_service, calendar_id, agg_event, stats)
    else
      raise
    end
  end
  
  # Create a new Google Calendar event
  def create_new_event(calendar_service, calendar_id, agg_event, stats)
    event = Google::Apis::CalendarV3::Event.new(
    summary: agg_event.title,
    description: build_event_description(agg_event),
    location: agg_event.venue&.dig(:name) || agg_event.location
    )
    
    # Set start and end times
    if agg_event.all_day?
      event.start = Google::Apis::CalendarV3::EventDateTime.new(
      date: agg_event.date.to_s
      )
      event.end = Google::Apis::CalendarV3::EventDateTime.new(
      date: agg_event.date.to_s
      )
    else
      start_time = parse_event_time(agg_event)
      end_time = start_time + 2.hours # Default 2 hour duration
      
      event.start = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: start_time.to_datetime.rfc3339,
      time_zone: 'America/Los_Angeles'
      )
      event.end = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: end_time.to_datetime.rfc3339,
      time_zone: 'America/Los_Angeles'
      )
    end
    
    # Create the event
    created_event = calendar_service.insert_event(calendar_id, event)
    stats[:created] += 1
    Rails.logger.info "[CalendarSyncJob] Created event: #{created_event.summary} (ID: #{created_event.id})"
    
    # Store the Google Calendar ID back to the aggregator event's metadata
    # Note: This may not persist depending on the aggregator implementation
    if agg_event.respond_to?(:metadata=)
      agg_event.metadata ||= {}
      agg_event.metadata[:google_calendar_id] = created_event.id
    end
  rescue => e
    Rails.logger.error "[CalendarSyncJob] Failed to create event '#{agg_event.title}': #{e.message}"
    raise
  end
  
  # Build a comprehensive description from event data
  def build_event_description(agg_event)
    description_parts = []
    
    # Add original description if present
    description_parts << agg_event.description if agg_event.description.present?
    
    # Add source information
    description_parts << "Source: #{agg_event.source}" if agg_event.source
    
    # Add attendance count if available
    description_parts << "Going: #{agg_event.going_count}" if agg_event.going_count
    
    # Add venue details if available
    if agg_event.venue
      venue_info = []
      venue_info << agg_event.venue[:name] if agg_event.venue[:name]
      venue_info << agg_event.venue[:address] if agg_event.venue[:address]
      description_parts << "Venue: #{venue_info.join(', ')}" unless venue_info.empty?
    end
    
    # Add status if notable
    description_parts << "Status: #{agg_event.status}" if agg_event.status.present?
    
    description_parts.join("\n\n")
  end
  
  # Parse event time from the aggregated event
  def parse_event_time(agg_event)
    # The event has a date and formatted_time
    # formatted_time might be like "7:00 PM" or "All Day"
    if agg_event.time.present?
      # Combine date with time
      Time.zone.parse("#{agg_event.date} #{agg_event.time}")
    else
      # Default to noon on the event date
      agg_event.date.to_time.change(hour: 12)
    end
  rescue
    # Fallback to noon if parsing fails
    agg_event.date.to_time.change(hour: 12)
  end
end
