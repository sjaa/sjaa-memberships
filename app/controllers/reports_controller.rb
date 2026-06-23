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
    if get_auth(@user).nil?
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to memberships_report_path(start: params[:start_date], end: params[:end_date], new_members_only: params[:new_members_only])
      return
    end

    group_name = params[:group_name]&.strip
    section = params[:section]
    start_date = params[:start_date].presence || Date.today.beginning_of_month.iso8601
    end_date = params[:end_date].presence || Date.today.end_of_month.iso8601
    new_members_only = params[:new_members_only] == '1'

    if group_name.blank?
      flash[:alert] = 'Group name cannot be empty.'
      redirect_to memberships_report_path(start: start_date, end: end_date, new_members_only: new_members_only)
      return
    end

    CreateGoogleGroupFromReportJob.perform_later_with_notifications(
      @user,
      @user.email,
      group_name,
      section,
      start_date.to_s,
      end_date.to_s,
      new_members_only
    )

    flash[:notice] = "Creating Google Group '#{group_name}@sjaa.net' in the background. You'll be notified when it's done."
    redirect_to memberships_report_path(start: start_date, end: end_date, new_members_only: new_members_only)
  end
end