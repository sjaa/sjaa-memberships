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

desc "Merge two people by ID (KEEPER=id DUPLICATE=id COMMIT=true to execute, otherwise dry-run)"
task merge_people: [:environment] do
  keeper_id = ENV['KEEPER']
  duplicate_id = ENV['DUPLICATE']
  commit = ENV['COMMIT'] == 'true'

  if keeper_id.nil? || duplicate_id.nil?
    puts "Error: Both KEEPER and DUPLICATE parameters are required"
    puts "Usage: rails merge_people KEEPER=123 DUPLICATE=456 [COMMIT=true]"
    puts "\nKEEPER: The person to keep (all data will be merged into this person)"
    puts "DUPLICATE: The person to merge and delete"
    exit 1
  end

  keeper = Person.find_by(id: keeper_id)
  duplicate = Person.find_by(id: duplicate_id)

  if keeper.nil?
    puts "Error: Keeper person with ID #{keeper_id} not found"
    exit 1
  end

  if duplicate.nil?
    puts "Error: Duplicate person with ID #{duplicate_id} not found"
    exit 1
  end

  if keeper.id == duplicate.id
    puts "Error: Cannot merge a person into itself"
    exit 1
  end

  puts "\n" + "=" * 80
  puts "MERGE PEOPLE"
  puts "=" * 80
  puts "Mode: #{commit ? 'COMMIT - Will merge people' : 'DRY RUN - No changes will be made'}"
  puts "=" * 80

  puts "\n  KEEPER (data will be merged INTO this person):"
  puts "    ID: #{keeper.id}"
  puts "    Name: #{keeper.name}"
  puts "    Email: #{keeper.primary_contact&.email}"
  puts "    Created: #{keeper.created_at}"
  puts "    Updated: #{keeper.updated_at}"

  puts "\n  DUPLICATE (will be merged and deleted):"
  puts "    ID: #{duplicate.id}"
  puts "    Name: #{duplicate.name}"
  puts "    Email: #{duplicate.primary_contact&.email}"
  puts "    Created: #{duplicate.created_at}"
  puts "    Updated: #{duplicate.updated_at}"

  # Use the PersonMerger service
  PersonMerger.merge!(keeper: keeper, duplicate: duplicate, commit: commit)

  puts "\n" + "=" * 80
  puts "MERGE COMPLETE"
  puts "=" * 80
  if commit
    puts "Successfully merged Person ##{duplicate_id} into Person ##{keeper_id}"
    puts "Person ##{duplicate_id} has been deleted"
  else
    puts "This was a DRY RUN - no changes were made"
    puts "Run with COMMIT=true to actually merge people"
  end
  puts "=" * 80 + "\n"
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

desc "Find and merge people with duplicate email addresses (COMMIT=true to execute, otherwise dry-run)"
task merge_duplicate_emails: [:environment] do
  commit = ENV['COMMIT'] == 'true'

  puts "\n" + "=" * 80
  puts "MERGE DUPLICATE EMAIL ADDRESSES"
  puts "=" * 80
  puts "Mode: #{commit ? 'COMMIT - Will merge duplicates' : 'DRY RUN - No changes will be made'}"
  puts "=" * 80 + "\n"

  # Find all emails that appear more than once (case-insensitive)
  duplicate_emails = Contact.select("LOWER(email) as email_lower, COUNT(*) as count")
                             .where.not(email: nil)
                             .group("LOWER(email)")
                             .having("COUNT(*) > 1")
                             .order("count DESC")

  if duplicate_emails.empty?
    puts "No duplicate emails found!"
    exit 0
  end

  puts "Found #{duplicate_emails.size} duplicate email addresses\n\n"

  total_people_merged = 0
  total_duplicates_removed = 0

  duplicate_emails.each_with_index do |dup, idx|
    email_lower = dup.email_lower
    count = dup.count

    # Get all contacts with this email (case-insensitive)
    contacts = Contact.where("LOWER(email) = ?", email_lower).includes(person: [:memberships, :donations, :equipment, :interests, :groups, :permissions, :people_skills])

    # Get the associated people
    people = contacts.map(&:person).uniq

    puts "\n#{"-" * 80}"
    puts "#{idx + 1}. Email: #{email_lower} (#{count} contacts, #{people.size} people)"
    puts "-" * 80

    people.each_with_index do |person, pidx|
      primary_contact = person.primary_contact
      latest_membership = person.latest_membership

      puts "\n  Person #{pidx + 1}:"
      puts "    ID: #{person.id}"
      puts "    Name: #{person.name}"
      puts "    Created: #{person.created_at}"
      puts "    Updated: #{person.updated_at}"
      puts "    Contacts: #{person.contacts.size}"
      puts "    Primary Email: #{primary_contact&.email}"
      puts "    Memberships: #{person.memberships.size}"
      puts "    Latest Membership: #{latest_membership&.start} (#{latest_membership&.term_months} months)" if latest_membership
      puts "    Donations: #{person.donations.size}"
      puts "    Equipment: #{person.equipment.size}"
      puts "    Interests: #{person.interests.size}"
      puts "    Groups: #{person.groups.size}"
      puts "    Permissions: #{person.permissions.size}"
      puts "    Skills: #{person.people_skills.size}"
      puts "    Notes: #{person.notes[0..100]}" if person.notes.present?
    end

    # Determine which person to keep (most recent updated_at)
    keeper = people.max_by(&:updated_at)
    duplicates = people - [keeper]

    if duplicates.empty?
      puts "\n  ℹ️  Only one person found for this email (may have multiple contacts)"
      next
    end

    puts "\n  ✓ KEEPER: Person ##{keeper.id} (#{keeper.name}) - Updated: #{keeper.updated_at}"
    puts "  ✗ TO MERGE: #{duplicates.map { |p| "##{p.id} (#{p.name})" }.join(", ")}"

    # Use the PersonMerger service to perform or preview the merge for each duplicate
    duplicates.each do |duplicate|
      PersonMerger.merge!(keeper: keeper, duplicate: duplicate, commit: commit)

      if commit
        total_duplicates_removed += 1
      end
    end

    if commit
      total_people_merged += 1
    end
  end

  puts "\n" + "=" * 80
  puts "MERGE COMPLETE"
  puts "=" * 80
  if commit
    puts "Groups merged: #{total_people_merged}"
    puts "Duplicate people removed: #{total_duplicates_removed}"
  else
    puts "This was a DRY RUN - no changes were made"
    puts "Potential groups to merge: #{duplicate_emails.size}"
    puts "Run with COMMIT=true to actually merge duplicates"
  end
  puts "=" * 80 + "\n"
end

desc "Delete corrupt events (nil summary and private visibility) from SJAA merged calendar (ADMIN=admin@email.com CALENDAR_ID=optional COMMIT=true)"
task delete_corrupt_calendar_events: [:environment] do
  include GoogleHelper

  admin_email = ENV['ADMIN']
  calendar_id = ENV['CALENDAR_ID'] || AppConfig.google_calendar_id
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