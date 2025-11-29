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

    # Show preview of what the merged record will look like (or already looks like after merge)
    # Calculate what would be merged
    all_memberships = people.flat_map(&:memberships).uniq
    all_donations = people.flat_map(&:donations).uniq
    all_equipment = people.flat_map(&:equipment).uniq
    all_contacts = people.flat_map(&:contacts).uniq
    all_interests = people.flat_map(&:interests).uniq
    all_groups = people.flat_map(&:groups).uniq
    all_permissions = people.flat_map(&:permissions).uniq
    all_skills_hash = {}
    people.each do |person|
      person.people_skills.each do |ps|
        if !all_skills_hash[ps.skill_id] || ps.skill_level > all_skills_hash[ps.skill_id][:level]
          all_skills_hash[ps.skill_id] = { skill: ps.skill, level: ps.skill_level }
        end
      end
    end

    # Show the preview/final merged record
    puts "\n  " + "=" * 76
    puts "  #{commit ? 'MERGED' : 'PREVIEW OF MERGED'} RECORD - Person ##{keeper.id}"
    puts "  " + "=" * 76
    puts "  Name: #{keeper.name}"
    puts "  Created: #{keeper.created_at}"
    puts "  Updated: #{keeper.updated_at}"

    # Show merged fields
    merged_discord = duplicates.find { |d| d.discord_id.present? }&.discord_id || keeper.discord_id
    merged_astrobin = duplicates.find { |d| d.astrobin_id.present? }&.astrobin_id || keeper.astrobin_id
    merged_telescopius = duplicates.find { |d| d.telescopius_id.present? }&.telescopius_id || keeper.telescopius_id
    merged_referral = duplicates.find { |d| d.referral_id.present? }&.referral || keeper.referral
    merged_volunteer = keeper.volunteer || duplicates.any?(&:volunteer)
    merged_mentor = keeper.mentor || duplicates.any?(&:mentor)

    puts "  Discord: #{merged_discord}" if merged_discord.present?
    puts "  AstroBin: #{merged_astrobin}" if merged_astrobin.present?
    puts "  Telescopius: #{merged_telescopius}" if merged_telescopius.present?
    puts "  Referral: #{merged_referral&.name}" if merged_referral.present?
    puts "  Volunteer: #{merged_volunteer ? 'Yes' : 'No'}"
    puts "  Mentor: #{merged_mentor ? 'Yes' : 'No'}"

    # Check for profile picture
    has_profile_pic = keeper.profile_picture.attached? || duplicates.any? { |d| d.profile_picture.attached? }
    if has_profile_pic
      pic_source = if keeper.profile_picture.attached?
        "from keeper"
      else
        dup_with_pic = duplicates.find { |d| d.profile_picture.attached? }
        "from Person ##{dup_with_pic.id}"
      end
      puts "  Profile Picture: Yes (#{pic_source})"
    end

    # Show all contacts
    puts "\n  Contacts (#{all_contacts.size}):"
    # Group contacts by email to show how duplicates will be handled
    contacts_by_email = all_contacts.group_by { |c| c.email&.downcase }
    contacts_by_email.each_with_index do |(email_key, contact_group), cidx|
      # Pick the most complete contact or the keeper's contact
      main_contact = contact_group.find { |c| c.person_id == keeper.id } || contact_group.first
      other_contacts = contact_group - [main_contact]

      primary_flag = main_contact.primary || (main_contact.person_id == keeper.id && keeper.primary_contact&.email&.downcase == email_key)
      puts "    #{cidx + 1}. #{main_contact.email}#{primary_flag ? ' (PRIMARY)' : ''}"

      # Show merged address info
      address = other_contacts.find { |c| c.address.present? }&.address || main_contact.address
      city = other_contacts.find { |c| c.city_id.present? }&.city || main_contact.city
      state = other_contacts.find { |c| c.state_id.present? }&.state || main_contact.state
      zipcode = other_contacts.find { |c| c.zipcode.present? }&.zipcode || main_contact.zipcode
      phone = other_contacts.find { |c| c.phone.present? }&.phone || main_contact.phone

      puts "       Address: #{address}" if address.present?
      puts "       City: #{city&.name}" if city.present?
      puts "       State: #{state&.name}" if state.present?
      puts "       Zipcode: #{zipcode}" if zipcode.present?
      puts "       Phone: #{phone}" if phone.present?

      if other_contacts.any? && !commit
        puts "       (Will merge data from #{other_contacts.size} duplicate contact(s))"
      end
    end

    # Show all memberships
    puts "\n  Memberships (#{all_memberships.size}):"
    all_memberships.sort_by { |m| m.start || DateTime.now }.reverse.each_with_index do |membership, midx|
      end_date = membership.end ? membership.end.strftime('%Y-%m-%d') : 'LIFETIME'
      status = membership.is_active? ? '✓ ACTIVE' : '✗ EXPIRED'
      source = membership.person_id == keeper.id ? '' : " (from Person ##{membership.person_id})"
      puts "    #{midx + 1}. #{membership.kind&.name}: #{membership.start&.strftime('%Y-%m-%d')} → #{end_date} (#{membership.term_months || 'N/A'} months) [#{status}]#{source}"
      puts "       Ephemeris: #{membership.ephemeris ? 'Yes' : 'No'}" if membership.respond_to?(:ephemeris)
    end

    # Show donations summary
    if all_donations.any?
      total_donations = all_donations.sum(&:amount)
      puts "\n  Donations (#{all_donations.count}): Total $#{total_donations}"
      all_donations.sort_by(&:created_at).reverse.first(5).each_with_index do |donation, didx|
        source = donation.person_id == keeper.id ? '' : " (from Person ##{donation.person_id})"
        if donation.notes.present?
          puts "    #{didx + 1}. $#{donation.amount} - #{donation.notes}#{source}"
        else
          puts "    #{didx + 1}. $#{donation.amount}#{source}"
        end
      end
      puts "    ... and #{all_donations.count - 5} more" if all_donations.count > 5
    end

    # Show equipment
    if all_equipment.any?
      puts "\n  Equipment (#{all_equipment.size}):"
      all_equipment.each_with_index do |equip, eidx|
        source = equip.person_id == keeper.id ? '' : " (from Person ##{equip.person_id})"
        instrument_display = equip.instrument ? "#{equip.instrument.kind}#{equip.instrument.model.present? ? " #{equip.instrument.model}" : ''}" : "Unknown"
        note_display = equip.note.present? ? " - #{equip.note}" : ''
        puts "    #{eidx + 1}. #{instrument_display}#{note_display}#{source}"
      end
    end

    # Show interests
    if all_interests.any?
      puts "\n  Interests (#{all_interests.count}): #{all_interests.uniq.map(&:name).join(', ')}"
    end

    # Show groups
    if all_groups.any?
      puts "\n  Groups (#{all_groups.count}): #{all_groups.uniq.map(&:name).join(', ')}"
    end

    # Show permissions
    if all_permissions.any?
      puts "\n  Permissions (#{all_permissions.count}): #{all_permissions.uniq.map(&:name).join(', ')}"
    end

    # Show skills
    if all_skills_hash.any?
      puts "\n  Skills (#{all_skills_hash.count}):"
      all_skills_hash.each_with_index do |(skill_id, skill_data), sidx|
        puts "    #{sidx + 1}. #{skill_data[:skill].name}: Level #{skill_data[:level]}"
      end
    end

    # Show merged notes
    all_notes = people.map(&:notes).compact.reject(&:blank?).uniq
    if all_notes.any?
      merged_notes = all_notes.join("\n---\n")
      notes_preview = merged_notes.length > 200 ? "#{merged_notes[0..200]}..." : merged_notes
      puts "\n  Notes: #{notes_preview}"
    end

    puts "  " + "=" * 76

    if commit
      ActiveRecord::Base.transaction do
        duplicates.each do |duplicate|
          puts "\n  Merging Person ##{duplicate.id} into Person ##{keeper.id}..."

          # Merge memberships (keep all, avoid duplicates)
          duplicate.memberships.each do |membership|
            # Check if keeper already has a membership with same start date and kind
            existing = keeper.memberships.find { |m| m.start == membership.start && m.kind_id == membership.kind_id }
            unless existing
              membership.update!(person_id: keeper.id)
              puts "    → Moved membership: #{membership.start} (#{membership.term_months} months)"
            else
              puts "    → Skipped duplicate membership: #{membership.start}"
            end
          end

          # Merge donations (keep all)
          duplicate.donations.each do |donation|
            donation.update!(person_id: keeper.id)
            puts "    → Moved donation: $#{donation.amount}"
          end

          # Merge equipment (keep all, avoid duplicates by instrument and note)
          duplicate.equipment.each do |equip|
            # Check if keeper already has equipment with same instrument and note
            existing = keeper.equipment.find { |e| e.instrument_id == equip.instrument_id && e.note == equip.note }
            unless existing
              equip.update!(person_id: keeper.id)
              instrument_display = equip.instrument ? "#{equip.instrument.kind}#{equip.instrument.model.present? ? " #{equip.instrument.model}" : ''}" : "Unknown"
              puts "    → Moved equipment: #{instrument_display}"
            else
              instrument_display = equip.instrument ? "#{equip.instrument.kind}#{equip.instrument.model.present? ? " #{equip.instrument.model}" : ''}" : "Unknown"
              puts "    → Skipped duplicate equipment: #{instrument_display}"
            end
          end

          # Merge contacts (keep all, but mark duplicates as non-primary)
          duplicate.contacts.each do |contact|
            # Check if this exact email already exists for keeper
            existing = keeper.contacts.find { |c| c.email&.downcase == contact.email&.downcase }
            if existing
              # If the duplicate's contact has more complete info, update the keeper's contact
              # Use update_columns to bypass validation (email uniqueness already satisfied)
              updates = {}
              if contact.address.present? && existing.address.blank?
                updates[:address] = contact.address
                puts "    → Updated keeper's contact address"
              end
              if contact.phone.present? && existing.phone.blank?
                updates[:phone] = contact.phone
                puts "    → Updated keeper's contact phone"
              end
              if contact.city_id.present? && existing.city_id.blank?
                updates[:city_id] = contact.city_id
                puts "    → Updated keeper's contact city"
              end
              if contact.state_id.present? && existing.state_id.blank?
                updates[:state_id] = contact.state_id
                puts "    → Updated keeper's contact state"
              end
              if contact.zipcode.present? && existing.zipcode.blank?
                updates[:zipcode] = contact.zipcode
                puts "    → Updated keeper's contact zipcode"
              end
              existing.update_columns(updates) if updates.any?

              # Delete the duplicate contact
              contact.destroy!
              puts "    → Deleted duplicate contact: #{contact.email}"
            else
              # Move contact to keeper, but ensure only one primary
              contact.update!(person_id: keeper.id, primary: false)
              puts "    → Moved contact: #{contact.email}"
            end
          end

          # Merge interests (union)
          new_interests = duplicate.interests - keeper.interests
          keeper.interests << new_interests
          puts "    → Added #{new_interests.size} interests" if new_interests.any?

          # Merge groups (union)
          new_groups = duplicate.groups - keeper.groups
          keeper.groups << new_groups
          puts "    → Added #{new_groups.size} groups" if new_groups.any?

          # Merge permissions (union)
          new_permissions = duplicate.permissions - keeper.permissions
          keeper.permissions << new_permissions
          puts "    → Added #{new_permissions.size} permissions" if new_permissions.any?

          # Merge skills (take highest skill level for each skill)
          duplicate.people_skills.each do |dup_skill|
            keeper_skill = keeper.people_skills.find { |ks| ks.skill_id == dup_skill.skill_id }
            if keeper_skill
              if dup_skill.skill_level > keeper_skill.skill_level
                keeper_skill.update!(skill_level: dup_skill.skill_level)
                puts "    → Updated skill level: #{dup_skill.skill.name} to #{dup_skill.skill_level}"
              end
            else
              dup_skill.update!(person_id: keeper.id)
              puts "    → Moved skill: #{dup_skill.skill.name} (level #{dup_skill.skill_level})"
            end
          end

          # Merge notes (append if different)
          if duplicate.notes.present? && duplicate.notes != keeper.notes
            keeper.notes = [keeper.notes, duplicate.notes].compact.join("\n---\n")
            keeper.save!
            puts "    → Appended notes"
          end

          # Merge other fields (favor keeper, but fill in blanks)
          if duplicate.discord_id.present? && keeper.discord_id.blank?
            keeper.update!(discord_id: duplicate.discord_id)
            puts "    → Updated discord_id"
          end
          if duplicate.astrobin_id.present? && keeper.astrobin_id.blank?
            keeper.update!(astrobin_id: duplicate.astrobin_id)
            puts "    → Updated astrobin_id"
          end
          if duplicate.telescopius_id.present? && keeper.telescopius_id.blank?
            keeper.update!(telescopius_id: duplicate.telescopius_id)
            puts "    → Updated telescopius_id"
          end
          if duplicate.referral_id.present? && keeper.referral_id.blank?
            keeper.update!(referral_id: duplicate.referral_id)
            puts "    → Updated referral_id"
          end
          keeper.update!(volunteer: true) if duplicate.volunteer && !keeper.volunteer
          keeper.update!(mentor: true) if duplicate.mentor && !keeper.mentor

          # Merge profile picture (if keeper doesn't have one but duplicate does)
          if duplicate.profile_picture.attached? && !keeper.profile_picture.attached?
            # Copy the blob from duplicate to keeper
            keeper.profile_picture.attach(duplicate.profile_picture.blob)
            puts "    → Attached profile picture from duplicate"
          end

          # Delete the duplicate person
          duplicate.reload.destroy!
          puts "    ✓ Deleted Person ##{duplicate.id}"
          total_duplicates_removed += 1
        end

        total_people_merged += 1
        puts "\n  ✓ Successfully merged #{duplicates.size} duplicate(s) into Person ##{keeper.id}"
      end
    else
      puts "\n  → Would merge #{duplicates.size} duplicate(s) into Person ##{keeper.id} (dry-run)"
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