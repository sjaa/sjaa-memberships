class CalendarSyncJob < ApplicationJob
  include GoogleHelper

  queue_as :default

  # Enable notifications for this job
  self.enable_notifications = true
  
  # CalendarSyncJob.perform_later(admin_email, calendar_id, days, commit)
  #   admin_email - Email of admin with valid refresh token for calendar access
  #   calendar_id - Google Calendar ID to update (defaults to ENV variable)
  #   days - Number of days to sync (defaults to 90 days / ~3 months)
  #   commit - Whether to commit changes to Google Calendar (defaults to false for dry-run)
  #
  # This job fetches events from the SJAA calendar aggregator for the specified
  # time period and syncs them to a Google Calendar, creating new events, updating
  # existing ones, and marking cancelled events.
  def perform(admin_email, calendar_id = nil, days = 90, commit = false)
    require 'sjaa-ruby-calendar-aggregator'

    calendar_id ||= AppConfig.google_calendar_id
    admin = Admin.find_by(email: admin_email)
    
    # Validate admin has refresh token
    if admin.nil?
      msg = "[CalendarSyncJob] Admin '#{admin_email}' not found"
      Rails.logger.error msg
      puts msg
      return
    end

    if admin.refresh_token.nil?
      msg = "[CalendarSyncJob] Admin '#{admin_email}' is missing a Google refresh token. Please authenticate via the Google integration page first."
      Rails.logger.error msg
      puts msg
      return
    end
    
    # Get Google Calendar service with auth
    auth = get_auth(admin)
    calendar_service = Google::Apis::CalendarV3::CalendarService.new
    calendar_service.authorization = auth
    
    # Fetch events from aggregator for specified number of days
    today = Date.today
    end_date = today + days.days
    
    Rails.logger.info "[CalendarSyncJob] Fetching aggregated events from #{today} to #{end_date}"
    
    # Create a simple configuration programmatically
    config = SJAA::Calendar::Configuration.new

    # Configure settings first (especially API key)
    config.max_events_per_day = 3
    config.prioritize_timed_events = true
    config.debug = true
    config.google_api_key = AppConfig.google_api_key

    # Add a Google Calendar source (you'll need to provide a real API key and calendar ID)
    config.add_google_calendar(
    name: "SJAA 2025 All Events",
    calendar_id: "c_4779ddc46fda914aaa8045b916044a480265c50bb4642df9420923706837a63e@group.calendar.google.com"
    )

    config.add_google_calendar(
    name: "SJAA Aggregate Calendar",
    calendar_id: "c_3ba3a0dda51b1e570c0fad01aa5bd96f1e27e5c05b5d3fd0fa581974a6305ecc@group.calendar.google.com"
    )

    # Add a Meetup source (optional so failures don't block the rest of the sync)
    config.add_meetup_source(
    name: "SJAA Meetup Events",
    meetup_url: "https://www.meetup.com/sj-astronomy/events/",
    timeout: 180
    )

    # Add moon phases
    config.add_moon_phase_source

    # Create aggregator
    aggregator = SJAA::Calendar::Aggregator.new(config)
    
    # Collect all events from the next 3 months
    aggregated_events = []
    
    calendar = aggregator.generate_calendar(today, end_date)
    aggregated_events = calendar.each_day.select{|date, events| date <= end_date  && date >= today}.flat_map { |date, events| events }

    Rails.logger.info "[CalendarSyncJob] Found #{aggregated_events.size} events to sync"
    
    # Track sync statistics
    stats = { created: [], updated: [], cancelled: [], errors: [] }
    
    # Process each aggregated event
    aggregated_events.each do |agg_event|
      begin
        sync_event(calendar_service, calendar_id, agg_event, stats, commit)
      rescue => e
        stats[:errors] << {event: agg_event, error: e}
        Rails.logger.error "[CalendarSyncJob] Error syncing event '#{agg_event.title}': #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
      end

      # Save Meetup events to database regardless of Google Calendar sync result
      save_meetup_event(agg_event) if is_meetup_event?(agg_event)
    end
    
    Rails.logger.info "[CalendarSyncJob] Sync complete: #{stats.inspect}"

    # Output summary report
    puts "\n" + "="*80
    puts "CALENDAR SYNC REPORT (commit=#{commit})"
    puts "="*80
    puts "\nSUMMARY:"
    puts "  Total events processed: #{aggregated_events.size}"
    puts "  Would be created: #{stats[:created].size}"
    puts "  Would be updated: #{stats[:updated].size}"
    puts "  Would be cancelled: #{stats[:cancelled].size}"
    puts "  Errors: #{stats[:errors].size}"

    puts "\n" + "-"*80
    puts "EVENTS TO BE CREATED (#{stats[:created].size}):"
    puts "-"*80
    stats[:created].each_with_index do |event, i|
      puts "#{i+1}. #{event.summary}"
      puts "   Date: #{event.start.date || event.start.date_time}"
      puts "   Location: #{event.location}" if event.location
    end

    puts "\n" + "-"*80
    puts "EVENTS TO BE UPDATED (#{stats[:updated].size}):"
    puts "-"*80
    stats[:updated].each_with_index do |event, i|
      puts "#{i+1}. #{event.summary}"
      puts "   Date: #{event.start.date || event.start.date_time}"
      puts "   Location: #{event.location}" if event.location
    end

    puts "\n" + "-"*80
    puts "EVENTS TO BE CANCELLED (#{stats[:cancelled].size}):"
    puts "-"*80
    stats[:cancelled].each_with_index do |event, i|
      puts "#{i+1}. #{event.summary}"
    end

    if stats[:errors].any?
      puts "\n" + "-"*80
      puts "ERRORS (#{stats[:errors].size}):"
      puts "-"*80
      stats[:errors].each_with_index do |err_hash, i|
        puts "#{i+1}. #{err_hash[:event].title}"
        puts "   Error: #{err_hash[:error].message}"
      end
    end

    puts "\n" + "="*80
    puts "END OF REPORT"
    puts "="*80 + "\n"
  end
  
  private
  
  # Sync a single event to Google Calendar
  def sync_event(calendar_service, calendar_id, agg_event, stats, commit=false)
    # Check if event already exists in Google Calendar
    # First try the event's direct ID, then check all source_events for matching IDs
    existing_event_id = find_existing_event_id(calendar_service, calendar_id, agg_event)

    # Check if event is cancelled based on status
    if agg_event&.status&.downcase&.include?('cancelled')
      handle_cancelled_event(calendar_service, calendar_id, agg_event, existing_event_id, stats, commit)
    elsif existing_event_id
      update_existing_event(calendar_service, calendar_id, agg_event, existing_event_id, stats, commit)
    else
      create_new_event(calendar_service, calendar_id, agg_event, stats, commit)
    end
  end

  # Find an existing event ID by checking the aggregated event's ID and all source event IDs
  def find_existing_event_id(calendar_service, calendar_id, agg_event)
    # Debug logging
    Rails.logger.debug "[CalendarSyncJob] Looking for existing event: '#{agg_event.title}'"
    Rails.logger.debug "[CalendarSyncJob]   Direct ID: #{agg_event.id.inspect}"

    # First try the direct event ID
    if agg_event.id && event_exists?(calendar_service, calendar_id, agg_event.id)
      Rails.logger.debug "[CalendarSyncJob]   Found via direct ID: #{agg_event.id}"
      return agg_event.id
    end

    # If the event has source_events, try each of their IDs
    if agg_event.respond_to?(:source_events) && agg_event.source_events.present?
      Rails.logger.debug "[CalendarSyncJob]   Checking #{agg_event.source_events.size} source events"
      agg_event.source_events.each do |source_event|
        source_id = source_event.respond_to?(:id) ? source_event.id : source_event[:id]
        Rails.logger.debug "[CalendarSyncJob]     Trying source ID: #{source_id.inspect}"
        if source_id && event_exists?(calendar_service, calendar_id, source_id)
          Rails.logger.debug "[CalendarSyncJob]   Found via source ID: #{source_id}"
          return source_id
        end
      end
    else
      Rails.logger.debug "[CalendarSyncJob]   No source_events available"
    end

    # No matching event found
    Rails.logger.debug "[CalendarSyncJob]   No existing event found"
    nil
  end

  # Check if an event exists in Google Calendar
  def event_exists?(calendar_service, calendar_id, event_id)
    # Request full event details including summary, description, etc.
    calendar_service.get_event(calendar_id, event_id, fields: '*')
    true
  rescue Google::Apis::ClientError => e
    if e.status_code == 404
      false
    else
      raise
    end
  end
  
  # Handle cancelled events
  def handle_cancelled_event(calendar_service, calendar_id, agg_event, existing_event_id, stats, commit=false)
    return unless existing_event_id

    # Fetch existing event and update title to reflect cancellation
    event = calendar_service.get_event(calendar_id, existing_event_id)
    
    # Update title with CANCELLED prefix if not already present
    unless event.summary.start_with?('[CANCELLED]')
      event.summary = "[CANCELLED] #{event.summary}"
      calendar_service.update_event(calendar_id, existing_event_id, event) if(commit)
      stats[:cancelled] << event
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
  def update_existing_event(calendar_service, calendar_id, agg_event, event_id, stats, commit=false)
    # Fetch the existing event
    event = calendar_service.get_event(calendar_id, event_id)
    
    # Update event properties from aggregated event
    event.summary = agg_event.title
    event.description = build_event_description(agg_event)
    event.location = agg_event.venue&.dig(:address)
    
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
    
    calendar_service.update_event(calendar_id, event_id, event) if(commit)
    stats[:updated] << event
    Rails.logger.info "[CalendarSyncJob] Updated event: #{event.summary}"
  rescue Google::Apis::ClientError => e
    if e.status_code == 404
      # Event no longer exists, create it instead
      Rails.logger.warn "[CalendarSyncJob] Event #{event_id} not found, creating new event"
      create_new_event(calendar_service, calendar_id, agg_event, stats, commit)
    else
      raise
    end
  end
  
  # Create a new Google Calendar event
  def create_new_event(calendar_service, calendar_id, agg_event, stats, commit=false)
    event = Google::Apis::CalendarV3::Event.new(
    summary: agg_event.title,
    description: build_event_description(agg_event),
    location: agg_event.venue&.dig(:address),
    visibility: 'public'
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
    if commit
      created_event = calendar_service.insert_event(calendar_id, event)
      stats[:created] << created_event
      Rails.logger.info "[CalendarSyncJob] Created event: #{created_event.summary} (ID: #{created_event.id})"
    else
      # In dry-run mode, just track the event object we would create
      stats[:created] << event
      Rails.logger.info "[CalendarSyncJob] Would create event: #{event.summary}"
    end
  rescue => e
    Rails.logger.error "[CalendarSyncJob] Failed to create event '#{agg_event.title}': #{e.message}"
    raise
  end
  
  # Build a comprehensive description from event data
  def build_event_description(agg_event)
    description_parts = []

    # Add Meetup URL at the top if this is a Meetup event
    if agg_event.respond_to?(:source_events) && agg_event.source_events.present?
      agg_event.source_events.each do |source_event|
        # Check if this is a Meetup source event with a URL
        if source_event.class.name.include?('Meetup') && source_event.respond_to?(:url) && source_event.url.present?
          description_parts << source_event.url
          break # Only add the first Meetup URL found
        end
      end
    end

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
    if agg_event.start_time.present?
      # Combine date with time
      Time.parse("#{agg_event.start_time}")
    else
      # Default to noon on the event date
      agg_event.date.to_time.change(hour: 12)
    end
  rescue
    # Fallback to noon if parsing fails
    agg_event.date.to_time.change(hour: 12)
  end

  # Check if an aggregated event has a Meetup source
  def is_meetup_event?(agg_event)
    return false unless agg_event.respond_to?(:source_events) && agg_event.source_events.present?

    agg_event.source_events.any? do |source_event|
      source_event.class.name.include?('Meetup')
    end
  end

  # Save or update a Meetup event in the database
  def save_meetup_event(agg_event)
    return unless agg_event.respond_to?(:source_events) && agg_event.source_events.present?

    # Find the Meetup source event
    meetup_source = agg_event.source_events.find do |source_event|
      source_event.class.name.include?('Meetup')
    end

    return unless meetup_source

    # Extract Meetup event data
    meetup_id = meetup_source.respond_to?(:id) ? meetup_source.id : nil
    url = meetup_source.respond_to?(:url) ? meetup_source.url : nil
    image_url = meetup_source&.image_url || meetup_source&.image_highres_url

    # Skip if we don't have a valid meetup_id
    return unless meetup_id.present?

    # Calculate event time
    event_time = if agg_event.all_day?
      agg_event.date.to_time.change(hour: 12) # Default to noon for all-day events
    else
      parse_event_time(agg_event)
    end

    # Find or initialize the MeetupEvent record
    meetup_event = MeetupEvent.find_or_initialize_by(meetup_id: meetup_id)

    # Update attributes
    meetup_event.assign_attributes(
      url: url,
      image_url: image_url,
      title: agg_event.title,
      time: event_time
    )

    # Save the record
    is_new = meetup_event.new_record?
    if meetup_event.save
      action = is_new ? "Created" : "Updated"
      Rails.logger.info "[CalendarSyncJob] #{action} Meetup event: #{meetup_event.title} (ID: #{meetup_id})"
    else
      Rails.logger.error "[CalendarSyncJob] Failed to save Meetup event: #{meetup_event.errors.full_messages.join(', ')}"
    end
  rescue => e
    Rails.logger.error "[CalendarSyncJob] Error saving Meetup event: #{e.message}"
  end
end
