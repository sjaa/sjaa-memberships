desc "Port data from an SJAA database"
task patch: [:environment] do
  require_relative('../../db/sjaa_port')
  include SjaaPort

  patch(ENV['PATCH_FILE'], ENV['COMMIT'])
end

desc "Compare CSV1 and CSV2 first two columns - used for reconciling membership lists"
task csv_compare: [:environment] do
  csv1 = ENV['CSV1']
  csv2= ENV['CSV2']

  csvh = {csv1 => [], csv2 => []}

  csvh.each do |file, arr|
    CSV.foreach(file, headers: true) do |row|
      key = "#{row[0].strip} #{row[1].strip}"
      arr << key
    end
  end

  results = csvh.deep_dup

  # Look for CSV1 items in CSV2
  #  When found, delete from both
  #  When not found, delete from CSV1
  #  Remainder is what's missing from the other
  csvh[csv1].each do |person|
    results[csv2].delete(person)
    results[csv1].delete(person)
  end

  puts "People in #{csv1} but not #{csv2}"
  puts results[csv1].inspect

  puts "\n------\n"

  puts "People in #{csv2} but not #{csv1}"
  puts results[csv2].inspect
end


desc "Add some fake people to the database"
task generate_data: [:environment] do
  require_relative('../../db/faker_seed')
  include FakerSeed
  generate_people(size: 100)
end

desc "Encode Google Client Secret JSON file to base64 (FILE=path/to/client_secret.json)"
task encode_google_secret: [:environment] do
  require 'base64'
  require 'json'

  file_path = ENV['FILE']

  if file_path.nil? || file_path.empty?
    puts "Error: FILE parameter is required"
    puts "Usage: rails encode_google_secret FILE=path/to/client_secret.json"
    exit 1
  end

  unless File.exist?(file_path)
    puts "Error: File not found: #{file_path}"
    exit 1
  end

  begin
    # Read and validate JSON
    json_content = File.read(file_path)
    JSON.parse(json_content) # Validate it's valid JSON

    # Encode to base64
    encoded = Base64.strict_encode64(json_content)

    puts "\n" + "=" * 80
    puts "Successfully encoded Google Client Secret file"
    puts "=" * 80
    puts "\nAdd this to your .env file:"
    puts "\nGOOGLE_WEB_CLIENT_BASE64=#{encoded}"
    puts "\n" + "=" * 80
  rescue JSON::ParserError => e
    puts "Error: Invalid JSON file: #{e.message}"
    exit 1
  rescue => e
    puts "Error: #{e.message}"
    exit 1
  end
end

desc "Delete corrupt events (nil summary and private visibility) from SJAA merged calendar (ADMIN=admin@email.com CALENDAR_ID=optional COMMIT=true)"
task delete_corrupt_calendar_events: [:environment] do
  include GoogleHelper

  admin_email = ENV['ADMIN']
  calendar_id = ENV['CALENDAR_ID'] || ENV.fetch('SJAA_MERGED_CALENDAR_ID')
  commit = ENV['COMMIT'] == 'true'

  if admin_email.nil? || admin_email.empty?
    puts "Error: ADMIN parameter is required"
    puts "Usage: rails delete_corrupt_calendar_events ADMIN=admin@email.com [CALENDAR_ID=calendar_id] [COMMIT=true]"
    exit 1
  end

  admin = Admin.find_by(email: admin_email)

  if admin.nil? || admin.refresh_token.nil?
    puts "Error: Admin #{admin_email} not found or missing refresh token"
    exit 1
  end

  # Get Google Calendar service with auth
  auth = get_auth(admin)
  calendar_service = Google::Apis::CalendarV3::CalendarService.new
  calendar_service.authorization = auth

  puts "\n" + "=" * 80
  puts "DELETE CORRUPT CALENDAR EVENTS"
  puts "=" * 80
  puts "Calendar ID: #{calendar_id}"
  puts "Admin: #{admin_email}"
  puts "Criteria: Events with nil/blank summary AND private visibility"
  puts "Commit: #{commit ? 'YES - WILL DELETE EVENTS' : 'NO - DRY RUN'}"
  puts "=" * 80 + "\n"

  # Fetch all events from the calendar (request all fields)
  all_events = []
  page_token = nil

  begin
    loop do
      result = calendar_service.list_events(
        calendar_id,
        page_token: page_token,
        max_results: 2500,
        single_events: true,
        order_by: 'startTime',
        time_min: (Time.now - 1.year).iso8601,
        time_max: (Time.now + 1.year).iso8601,
        fields: '*'
      )

      all_events.concat(result.items) if result.items

      page_token = result.next_page_token
      break unless page_token
    end

    puts "Found #{all_events.size} total events\n\n"
    puts "=" * 80
    puts "ALL EVENTS:"
    puts "=" * 80

    # Show all events first
    all_events.each_with_index do |event, index|
      event_start = event.start&.date_time || event.start&.date || 'Unknown date'
      event_id = event.id
      event_summary = event.summary.present? ? event.summary : '(nil/blank)'
      event_description = if event.description.present?
                            desc = event.description[0..99]
                            desc += '...' if event.description.length > 100
                            desc
                          else
                            '(none)'
                          end
      event_visibility = event.visibility || 'default'
      event_location = event.location.present? ? event.location : '(none)'
      is_corrupt = (event.summary.nil? || event.summary.strip.empty?) && event.visibility == 'private'

      puts "\n#{index + 1}. Event Details:"
      puts "   ID: #{event_id}"
      puts "   Start: #{event_start}"
      puts "   Summary: #{event_summary}"
      puts "   Description: #{event_description}"
      puts "   Location: #{event_location}"
      puts "   Visibility: #{event_visibility}"
      puts "   Status: #{event.status}"
      puts "   CORRUPT: #{is_corrupt ? 'YES ⚠️' : 'No'}"
    end

    # Filter for corrupt events: nil/blank summary AND private visibility
    corrupt_events = all_events.select do |event|
      (event.summary.nil? || event.summary.strip.empty?) && event.visibility == 'private'
    end

    puts "\n\n" + "=" * 80
    puts "CORRUPT EVENTS TO BE DELETED:"
    puts "=" * 80
    puts "Found #{corrupt_events.size} corrupt events (nil/blank summary + private visibility)\n\n"

    deleted_count = 0
    error_count = 0

    corrupt_events.each_with_index do |event, index|
      event_start = event.start&.date_time || event.start&.date || 'Unknown date'
      event_id = event.id
      event_summary = event.summary.present? ? event.summary : '(nil/blank)'
      event_description = if event.description.present?
                            desc = event.description[0..99]
                            desc += '...' if event.description.length > 100
                            desc
                          else
                            '(none)'
                          end
      event_visibility = event.visibility || 'default'
      event_location = event.location.present? ? event.location : '(none)'

      puts "\n#{index + 1}. Event Details:"
      puts "   ID: #{event_id}"
      puts "   Start: #{event_start}"
      puts "   Summary: #{event_summary}"
      puts "   Description: #{event_description}"
      puts "   Location: #{event_location}"
      puts "   Visibility: #{event_visibility}"
      puts "   Status: #{event.status}"

      begin
        if commit
          calendar_service.delete_event(calendar_id, event_id)
          puts "   ACTION: DELETED ✓"
          deleted_count += 1
        else
          puts "   ACTION: Would delete (dry-run)"
        end
      rescue Google::Apis::ClientError => e
        puts "   ACTION: ERROR - #{e.message}"
        error_count += 1
      end
    end

    puts "\n" + "=" * 80
    puts "DELETION COMPLETE"
    puts "=" * 80
    if commit
      puts "Deleted: #{deleted_count} corrupt events"
      puts "Errors: #{error_count} events"
    else
      puts "Would delete: #{corrupt_events.size} corrupt events"
      puts "Run with COMMIT=true to actually delete events"
    end
    puts "=" * 80 + "\n"

  rescue Google::Apis::ClientError => e
    puts "\nError accessing calendar: #{e.message}"
    exit 1
  rescue => e
    puts "\nUnexpected error: #{e.message}"
    puts e.backtrace.join("\n")
    exit 1
  end
end