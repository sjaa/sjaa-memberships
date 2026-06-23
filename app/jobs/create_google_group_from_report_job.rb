class CreateGoogleGroupFromReportJob < ApplicationJob
  queue_as :default
  include GoogleHelper
  include ReportsHelper

  self.enable_notifications = true

  # CreateGoogleGroupFromReportJob.perform_later(
  #   admin_email, group_name, section, start_date, end_date, new_members_only
  # )
  #
  # Creates a Google Group from a membership report section.
  #   admin_email     - Email of the admin with Google auth (e.g. vp@sjaa.net)
  #   group_name      - Desired group name (without @sjaa.net)
  #   section         - 'gained' or 'lost'
  #   start_date      - Report start date as ISO8601 string
  #   end_date        - Report end date as ISO8601 string
  #   new_members_only - Boolean, filter to brand-new members only
  def perform(admin_email, group_name, section, start_date, end_date, new_members_only)
    admin = Admin.find_by(email: admin_email)
    unless admin&.refresh_token.present?
      Rails.logger.error "[CreateGoogleGroupFromReportJob] Admin #{admin_email} not found or has no refresh token"
      return
    end

    auth = get_auth(admin)
    if auth.nil?
      Rails.logger.error "[CreateGoogleGroupFromReportJob] Could not get Google auth for #{admin_email}"
      return
    end

    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    report = membership_report(date_range: start_date..end_date, new_members_only: new_members_only)

    people = case section
    when 'gained' then report[:new_memberships].keys
    when 'lost'   then report[:lost_memberships].keys
    else []
    end

    emails = people.map(&:email).compact.reject(&:blank?)

    if emails.empty?
      Rails.logger.warn "[CreateGoogleGroupFromReportJob] No email addresses found for section '#{section}'"
      return
    end

    group_email = "#{group_name}@sjaa.net"

    client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client.authorization = auth

    group = Google::Apis::AdminDirectoryV1::Group.new(
      email: group_email,
      name: group_name.titleize,
      description: "Created from membership report #{section} for #{start_date} to #{end_date}"
    )

    client.insert_group(group)
    sleep(2)

    begin
      if admin.email.present?
        manager = Google::Apis::AdminDirectoryV1::Member.new(email: admin.email, role: 'MANAGER')
        client.insert_member(group_email, manager)
      end
    rescue Google::Apis::ClientError => e
      Rails.logger.warn "[CreateGoogleGroupFromReportJob] Could not add #{admin.email} as manager: #{e.message}"
    end

    begin
      settings_service = Google::Apis::GroupssettingsV1::GroupssettingsService.new
      settings_service.authorization = auth
      settings_service.update_group(group_email, Google::Apis::GroupssettingsV1::Groups.new(who_can_post_message: 'ALL_MANAGERS_CAN_POST'))
    rescue => e
      Rails.logger.warn "[CreateGoogleGroupFromReportJob] Could not update group settings for #{group_email}: #{e.message}"
    end

    errors = []
    emails.each do |email|
      next if email.downcase == admin.email&.downcase

      begin
        member = Google::Apis::AdminDirectoryV1::Member.new(email: email, role: 'MEMBER')
        client.insert_member(group_email, member)
      rescue Google::Apis::ClientError => e
        if e.message.include?('notFound') || e.message.include?('Resource Not Found')
          sleep(2)
          begin
            client.insert_member(group_email, member)
          rescue Google::Apis::ClientError => retry_error
            errors << "#{email}: #{retry_error.message}"
          end
        else
          errors << "#{email}: #{e.message}"
        end
      end
    end

    if errors.any?
      Rails.logger.warn "[CreateGoogleGroupFromReportJob] #{group_email} created with #{emails.count} members, #{errors.count} errors: #{errors.join('; ')}"
    else
      Rails.logger.info "[CreateGoogleGroupFromReportJob] #{group_email} created successfully with #{emails.count} members"
    end
  end
end
