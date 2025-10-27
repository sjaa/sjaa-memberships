class AddMemberToGroupJob < ApplicationJob
  queue_as :default
  include JobsHelper
  include GoogleHelper

  # AddMemberToGroupJob.perform_later(person_id, admin_email)
  #   person_id - ID of the person to add to the members group
  #   admin_email - Email of admin account with Google Groups access (e.g. vp@sjaa.net)
  #
  # Adds a newly active member to the members@sjaa.net Google Group
  def perform(person_id, admin_email = nil)
    person = Person.find_by(id: person_id)

    unless person
      Rails.logger.error "[AddMemberToGroupJob] Person with ID #{person_id} not found"
      return
    end

    # Check if person is actually active
    unless person.is_active?
      Rails.logger.info "[AddMemberToGroupJob] Person #{person.id} (#{person.email}) is not active, skipping"
      return
    end

    # Get person's email
    email = person.email
    unless email.present?
      Rails.logger.warn "[AddMemberToGroupJob] Person #{person.id} has no email address, skipping"
      return
    end

    # Find an admin to use for Google API access
    # Use provided admin_email, or fall back to any admin with a refresh token
    admin = if admin_email.present?
      Admin.find_by(email: admin_email)
    else
      Admin.where.not(refresh_token: nil).first
    end

    unless admin&.refresh_token.present?
      Rails.logger.error "[AddMemberToGroupJob] No admin with Google credentials found. Admin email: #{admin_email}"
      return
    end

    begin
      # Get Google API authorization
      auth = get_auth(admin)

      # Create Google API client
      client = Google::Apis::AdminDirectoryV1::DirectoryService.new
      client.authorization = auth

      # Check if member is already in the group
      begin
        existing_member = client.get_member(GoogleHelper::MEMBERS_GROUP, email)
        if existing_member
          Rails.logger.info "[AddMemberToGroupJob] Person #{person.id} (#{email}) is already in #{GoogleHelper::MEMBERS_GROUP}"
          return
        end
      rescue Google::Apis::ClientError => e
        # 404 error means member is not in group, which is expected
        if e.status_code == 404
          # Continue to add the member
        else
          raise e
        end
      end

      # Add member to the group
      member = Google::Apis::AdminDirectoryV1::Member.new(email: email)
      client.insert_member(GoogleHelper::MEMBERS_GROUP, member)

      Rails.logger.info "[AddMemberToGroupJob] Successfully added #{email} to #{GoogleHelper::MEMBERS_GROUP}"

    rescue => e
      Rails.logger.error "[AddMemberToGroupJob] Failed to add #{email} to #{GoogleHelper::MEMBERS_GROUP}: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e
    end
  end
end
