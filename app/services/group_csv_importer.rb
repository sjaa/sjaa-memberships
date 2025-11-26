class GroupCsvImporter
  include GoogleHelper

  attr_reader :group, :auth, :csv_content, :results

  def initialize(group:, auth:, csv_content:)
    @group = group
    @auth = auth
    @csv_content = csv_content
    @results = {
      added: [],
      skipped: [],
      errors: [],
      added_to_db: []
    }
  end

  def import
    # Validate group has email
    unless group.email.present?
      Rails.logger.error "[GroupCsvImporter] Group #{group.id} does not have a Google Group email address"
      return { success: false, error: "Group does not have a Google Group email address configured." }
    end

    Rails.logger.info "[GroupCsvImporter] Starting import for group #{group.id} (#{group.email})"

    # Parse CSV
    emails = parse_csv
    return emails unless emails[:success]

    emails = emails[:emails]
    Rails.logger.info "[GroupCsvImporter] Found #{emails.count} email addresses in CSV"

    # Create Google API client
    client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client.authorization = auth

    # Verify Google Group exists
    Rails.logger.info "[GroupCsvImporter] Verifying Google Group exists: #{group.email}"
    verification = verify_group(client)
    return verification unless verification[:success]
    Rails.logger.info "[GroupCsvImporter] Google Group verified successfully"

    # Process each email
    process_emails(client, emails)

    Rails.logger.info "[GroupCsvImporter] Import completed: #{@results[:added].count} added, " \
                      "#{@results[:skipped].count} skipped, " \
                      "#{@results[:added_to_db].count} added to DB, " \
                      "#{@results[:errors].count} errors"

    { success: true, results: @results }
  end

  private

  def parse_csv
    require 'csv'
    Rails.logger.debug "[GroupCsvImporter] Parsing CSV content (#{csv_content.bytesize} bytes)"
    csv_data = CSV.parse(csv_content, headers: true)

    # Extract email addresses from the CSV
    # Look for column named "Email address" (case-insensitive)
    email_column = csv_data.headers.find { |h| h&.downcase&.strip == "email address" }

    # If we can't find the email column, try skipping the first line and parsing again
    unless email_column
      Rails.logger.debug "[GroupCsvImporter] Email column not found, trying to skip first line"
      lines = csv_content.lines
      if lines.length > 2
        csv_content_without_first = lines[1..-1].join
        csv_data = CSV.parse(csv_content_without_first, headers: true)
        email_column = csv_data.headers.find { |h| h&.downcase&.strip == "email address" }
        Rails.logger.debug "[GroupCsvImporter] Retried with first line skipped, email column #{email_column ? 'found' : 'not found'}"
      end
    end

    unless email_column
      Rails.logger.error "[GroupCsvImporter] CSV does not contain 'Email address' column. Headers: #{csv_data.headers.inspect}"
      return { success: false, error: "CSV must contain an 'Email address' column." }
    end

    emails = csv_data.map { |row| row[email_column]&.strip }.compact.reject(&:empty?)

    if emails.empty?
      Rails.logger.error "[GroupCsvImporter] No valid email addresses found in CSV"
      return { success: false, error: "No valid email addresses found in CSV." }
    end

    Rails.logger.debug "[GroupCsvImporter] Successfully extracted #{emails.count} emails from column '#{email_column}'"
    { success: true, emails: emails }

  rescue CSV::MalformedCSVError => e
    Rails.logger.error "[GroupCsvImporter] Malformed CSV: #{e.message}"
    { success: false, error: "Invalid CSV file: #{e.message}" }
  end

  def verify_group(client)
    client.get_group(group.email)
    { success: true }
  rescue Google::Apis::ClientError => e
    if e.status_code == 404
      Rails.logger.error "[GroupCsvImporter] Google Group '#{group.email}' not found (404)"
      { success: false, error: "Google Group '#{group.email}' does not exist or you don't have permission to access it." }
    else
      Rails.logger.error "[GroupCsvImporter] Error accessing Google Group '#{group.email}': #{e.message}"
      { success: false, error: "Error accessing Google Group '#{group.email}': #{e.message}" }
    end
  end

  def process_emails(client, emails)
    total = emails.count
    Rails.logger.info "[GroupCsvImporter] Processing #{total} email addresses"

    emails.each_with_index do |email, index|
      progress = index + 1
      Rails.logger.debug "[GroupCsvImporter] [#{progress}/#{total}] Processing: #{email}"

      # Try to find person by email in the database
      person = Person.find_by_email(email)

      # Add person to the group's database object if found
      if person
        if !group.people.include?(person)
          group.people << person
          @results[:added_to_db] << email
          Rails.logger.info "[GroupCsvImporter] [#{progress}/#{total}] Added #{email} to database group (Person ID: #{person.id})"
        else
          Rails.logger.debug "[GroupCsvImporter] [#{progress}/#{total}] #{email} already in database group (Person ID: #{person.id})"
        end
      else
        Rails.logger.debug "[GroupCsvImporter] [#{progress}/#{total}] No matching person found in database for #{email}"
      end

      # Add to Google Group
      begin
        member = Google::Apis::AdminDirectoryV1::Member.new(
          email: email,
          role: 'MEMBER',
          type: 'USER'
        )
        client.insert_member(group.email, member)
        @results[:added] << email
        Rails.logger.info "[GroupCsvImporter] [#{progress}/#{total}] Added #{email} to Google Group"
      rescue Google::Apis::ClientError => e
        # Handle duplicate member error gracefully
        if e.status_code == 409 || e.message.include?("Member already exists") || e.message.include?("duplicate")
          @results[:skipped] << email
          Rails.logger.debug "[GroupCsvImporter] [#{progress}/#{total}] Skipped #{email} (already in Google Group)"
        else
          @results[:errors] << { email: email, error: e.message }
          Rails.logger.error "[GroupCsvImporter] [#{progress}/#{total}] Error adding #{email} to Google Group: #{e.message}"
        end
      rescue => e
        @results[:errors] << { email: email, error: e.message }
        Rails.logger.error "[GroupCsvImporter] [#{progress}/#{total}] Unexpected error adding #{email}: #{e.class.name} - #{e.message}"
      end

      # Log progress every 10 emails
      if progress % 10 == 0
        Rails.logger.info "[GroupCsvImporter] Progress: #{progress}/#{total} emails processed"
      end
    end
  end
end
