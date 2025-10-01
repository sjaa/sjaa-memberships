require 'google/api_client/client_secrets'

class GoogleController < ApplicationController
  append_before_action :set_auth
  include GoogleHelper

  def groups
    if(@auth.nil?)
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to google_auth_path
      return
    end

    # Get all joinable roles with email addresses, plus the hardcoded members group
    @roles = Role.where(joinable: true).where.not(email: [nil, ''])
  end

  def group_sync
    if(@auth.nil?)
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to google_auth_path
      return
    end

    # Determine which group to sync
    @role_id = params[:role_id]
    @group_email = nil
    @role = nil
    @members_only = false

    if @role_id.present? && @role_id != 'members'
      begin
        @role = Role.find(@role_id)
        @group_email = @role.email
        @members_only = @role.members_only
        @group_name = @role.name

        # Validate that the role has an email
        if @group_email.blank?
          flash[:alert] = "The selected role does not have a Google Group email address configured."
          redirect_to google_groups_path
          return
        end
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The selected role could not be found."
        redirect_to google_groups_path
        return
      end
    else
      # Default to hardcoded members group
      @group_email = GoogleHelper::MEMBERS_GROUP
      @members_only = true
      @group_name = "Members"
      @role_id = 'members'
    end

    @diff = params[:diff].present?
    @commit = params[:commit].present?

    begin
      if(@commit)
        diff_results = sync(auth: @auth, group: @group_email, role: @role, members_only: @members_only, save: !params[:add_only], add_only: params[:add_only])
      end

      if(@diff)
        diff_results ||= diff_group(auth: @auth, group: @group_email, role: @role, members_only: @members_only)
        @group_matched = diff_results[:group_matched]
        @unmatched_people = diff_results[:unmatched_people]
        @group_unmatched = diff_results[:group_unmatched]
      else
        @members = get_members(auth: @auth, group: @group_email)
      end # if diff
    rescue Google::Apis::ClientError => e
      flash[:alert] = "Google API Error: #{e.message}. Please verify that the group email '#{@group_email}' exists and you have permission to access it."
      redirect_to google_groups_path
    end
  end

  # Legacy route - redirects to new groups page
  def members
    redirect_to google_groups_path
  end

  # Calendar snippets
  # cl = client.list_calendar_lists
  # aecl = cl.items.select{|c| c.summary =~ /2025 sjaa all events/i}
  # feb_events = client.list_events(aecl.id, time_min: DateTime.now.beginning_of_month, time_max: DateTime.now.end_of_month)
  # sorted = feb_events.items.sort{|a,b| (a.start.date || a.start.date_time) <=> (b.start.date || b.start.date_time)}
  # event_days = sorted.map do |ev|
  #   s = ev.start.date || ev.start.date_time
  #   e = ev.end.date || ev.end.date_time
  #   arr = (e-s).to_i.times.map{|t| ev}
  #   arr << ev
  # end.flatten

  private
  def set_auth
    @auth = get_auth(@user)
  end
end
