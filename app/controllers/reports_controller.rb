class ReportsController < ApplicationController
  include ReportsHelper
  include Filterable
  include ApplicationHelper
  include GoogleHelper

  def ephemeris
    people_filter({ephemeris: 'printed'})

    if(params[:page])
      render turbo_stream: turbo_stream.replace('people', partial: 'people/ephemeris_index')
      return
    end

    respond_to do |format|
      format.html
      format.csv do
        csv_data = CSV.generate(headers: true) do |csv|
          csv << ['First Name', 'Last Name', 'Address', 'City', 'State', 'Zip']
          @all_people.each do |person|
            csv << [
            person.first_name,
            person.last_name,
            person.primary_contact&.address,
            person.primary_contact&.city&.name,
            person.primary_contact&.state&.name,
            person.primary_contact&.zipcode,
            ]
          end
        end

        send_data csv_data, filename: "sjaa-ephemeris-#{Date.today}.csv"
      end
    end
  end

  def memberships
    @start_date = params[:start].present? ? Date.strptime(params[:start]) : Date.today.beginning_of_month
    @end_date = params[:end].present? ? Date.strptime(params[:end]) : Date.today.end_of_month
    @new_members_only = params[:new_members_only] == '1'
    @report = membership_report(date_range: @start_date..@end_date, new_members_only: @new_members_only)

    respond_to do |format|
      format.html
      format.csv do
        csv_type = params[:csv_type] # 'gained' or 'lost'

        csv_data = CSV.generate(headers: true) do |csv|
          csv << ['First Name', 'Last Name', 'Email']

          people = case csv_type
          when 'gained'
            @report[:new_memberships].keys
          when 'lost'
            @report[:lost_memberships].keys
          else
            []
          end

          people.each do |person|
            csv << [
              person.first_name,
              person.last_name,
              person.email
            ]
          end
        end

        filename = "sjaa-memberships-#{csv_type}-#{@start_date}-to-#{@end_date}.csv"
        send_data csv_data, filename: filename
      end
    end
  end

  def renewal_reminders
    @people = Person.renewable_members.sort_by{|person| person.latest_membership.end}
    @table = [['ID', 'Name', 'Status', 'Email', 'Membership End', 'Membership Start', 'Term']]
    @table += @people.map{|person| [person.id, person.name, person.status, person.email, date_format(person.latest_membership&.end), date_format(person.latest_membership&.start), person.latest_membership&.term_months]}

    respond_to do |format|
      format.html
      format.csv do
        csv_data = CSV.generate(headers: true) do |csv|
          @table.each do |row|
            csv << row
          end
        end

        send_data csv_data, filename: "sjaa-renewal-reminders-#{Date.today}.csv"
      end
    end
  end

  def create_google_group
    # Check if user has Google auth
    auth = get_auth(@user)
    if auth.nil?
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to memberships_report_path(start: params[:start_date], end: params[:end_date], new_members_only: params[:new_members_only])
      return
    end

    # Get parameters
    group_name = params[:group_name]&.strip
    section = params[:section] # 'gained' or 'lost'
    start_date = params[:start_date].present? ? Date.strptime(params[:start_date]) : Date.today.beginning_of_month
    end_date = params[:end_date].present? ? Date.strptime(params[:end_date]) : Date.today.end_of_month
    new_members_only = params[:new_members_only] == '1'

    # Validate group name
    if group_name.blank?
      flash[:alert] = 'Group name cannot be empty.'
      redirect_to memberships_report_path(start: start_date, end: end_date, new_members_only: new_members_only)
      return
    end

    # Generate the report to get the list of people
    report = membership_report(date_range: start_date..end_date, new_members_only: new_members_only)

    # Get the people based on section
    people = case section
    when 'gained'
      report[:new_memberships].keys
    when 'lost'
      report[:lost_memberships].keys
    else
      []
    end

    # Get email addresses
    emails = people.map(&:email).compact.reject(&:blank?)

    if emails.empty?
      flash[:alert] = 'No email addresses found for the selected section.'
      redirect_to memberships_report_path(start: start_date, end: end_date, new_members_only: new_members_only)
      return
    end

    # Create the Google Group
    begin
      client = Google::Apis::AdminDirectoryV1::DirectoryService.new
      client.authorization = auth

      # Create the group email
      group_email = "#{group_name}@sjaa.net"

      # Create the group
      group = Google::Apis::AdminDirectoryV1::Group.new(
        email: group_email,
        name: group_name.titleize,
        description: "Created from membership report #{section} for #{start_date} to #{end_date}"
      )

      created_group = client.insert_group(group)

      # Wait for the group to propagate in Google's system
      # This is necessary to avoid "Resource Not Found: groupKey" errors
      sleep(2)

      # Add the current user as a manager of the group
      begin
        current_user_email = @user.email
        if current_user_email.present?
          manager = Google::Apis::AdminDirectoryV1::Member.new(email: current_user_email, role: 'MANAGER')
          client.insert_member(group_email, manager)
        end
      rescue Google::Apis::ClientError => e
        Rails.logger.warn "Could not add current user as manager for #{group_email}: #{e.message}"
      end

      # Configure group settings to restrict posting to managers only
      begin
        settings_service = Google::Apis::GroupssettingsV1::GroupssettingsService.new
        settings_service.authorization = auth

        group_settings = Google::Apis::GroupssettingsV1::Groups.new(
          who_can_post_message: 'ALL_MANAGERS_CAN_POST'
        )

        settings_service.update_group(group_email, group_settings)
      rescue => e
        # Log the error but don't fail the entire operation
        Rails.logger.warn "Could not update group settings for #{group_email}: #{e.message}"
      end

      # Add members to the group
      errors = []
      emails.each do |email|
        # Skip if this email is the current user (already added as manager)
        next if email.downcase == @user.email&.downcase

        begin
          member = Google::Apis::AdminDirectoryV1::Member.new(email: email, role: 'MEMBER')
          client.insert_member(group_email, member)
        rescue Google::Apis::ClientError => e
          # Retry once after a delay if we get a "not found" error
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

      if errors.empty?
        flash[:success] = "Google Group '#{group_email}' created successfully with #{emails.count} members."
      else
        flash[:alert] = "Google Group '#{group_email}' created, but some members could not be added:<br/>#{errors.join('<br/>')}".html_safe
      end

    rescue Google::Apis::ClientError => e
      if e.message.include?('Entity already exists') || e.message.include?('duplicate')
        flash[:alert] = "A Google Group with the name '#{group_name}@sjaa.net' already exists. Please choose a different name."
      else
        flash[:alert] = "Error creating Google Group: #{e.message}"
      end
    rescue StandardError => e
      flash[:alert] = "An unexpected error occurred: #{e.message}"
    end

    redirect_to memberships_report_path(start: start_date, end: end_date, new_members_only: new_members_only)
  end
end