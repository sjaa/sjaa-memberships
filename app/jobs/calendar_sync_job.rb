class CalendarSyncJob < ApplicationJob
  include GoogleHelper

  queue_as :default
  
  # CalendarSyncJob.perform_later(admin_email, calendar_id)
  #   admin_email - Email of admin with valid refresh token for calendar access
  #   calendar_id - Google Calendar ID to update (defaults to ENV variable)
  #
  # This job fetches 3 months of events from the SJAA calendar aggregator
  # and syncs them to a Google Calendar, creating new events, updating existing
  # ones, and marking cancelled events.
  def perform(admin_email, calendar_id = nil)
    require 'sjaa-ruby-calendar-aggregator'
    
    calendar_id ||= ENV.fetch('SJAA_ALL_EVENTS_CALENDAR_ID')
    admin = Admin.find_by(email: admin_email)
    commit = true
    
    # Validate admin has refresh token
    if admin&.refresh_token.nil?
      Rails.logger.error "[CalendarSyncJob] Admin #{admin_email} not found or missing refresh token"
      return
    end
    
    # Get Google Calendar service with auth
    auth = get_auth(admin)
    calendar_service = Google::Apis::CalendarV3::CalendarService.new
    calendar_service.authorization = auth
    
    # Fetch events from aggregator for next 3 months
    today = Date.today
    end_date = today + 3.months
    
    Rails.logger.info "[CalendarSyncJob] Fetching aggregated events from #{today} to #{end_date}"
    
    # Create a simple configuration programmatically
    config = SJAA::Calendar::Configuration.new

    # Configure settings first (especially API key)
    config.max_events_per_day = 3
    config.prioritize_timed_events = true
    config.debug = true
    config.google_api_key = ENV['SJAA_GOOGLE_API_KEY']

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
    # Check if event already exists in Google Calendar via id
    existing_event_id = agg_event.id

    # Check if event is cancelled based on status
    if agg_event&.status&.downcase&.include?('cancelled')
      handle_cancelled_event(calendar_service, calendar_id, agg_event, existing_event_id, stats, commit)
    elsif existing_event_id
      update_existing_event(calendar_service, calendar_id, agg_event, existing_event_id, stats, commit)
    else
      create_new_event(calendar_service, calendar_id, agg_event, stats, commit)
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
    location: agg_event.venue&.dig(:address)
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
      Rails.logger.info "[CalendarSyncJob] Created event: #{created_event.summary} (ID: #{created_event.id})"
    else
      # In dry-run mode, just track the event object we would create
      Rails.logger.info "[CalendarSyncJob] Would create event: #{event.summary}"
    end

    stats[:created] << event
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
