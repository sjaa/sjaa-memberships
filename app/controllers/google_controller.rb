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

    # Get all joinable groups with email addresses, plus the hardcoded members group
    @groups = Group.where(joinable: true).where.not(email: [nil, ''])
  end

  def group_sync
    if(@auth.nil?)
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to google_auth_path
      return
    end

    # Determine which group to sync
    @group_id = params[:group_id]
    @group_email = nil
    @group = nil
    @members_only = false

    if @group_id.present? && @group_id != 'members'
      begin
        @group = Group.find(@group_id)
        @group_email = @group.email
        @members_only = @group.members_only
        @group_name = @group.name

        # Validate that the group has an email
        if @group_email.blank?
          flash[:alert] = "The selected group does not have a Google Group email address configured."
          redirect_to google_groups_path
          return
        end
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The selected group could not be found."
        redirect_to google_groups_path
        return
      end
    else
      # Default to hardcoded members group
      @group_email = GoogleHelper::MEMBERS_GROUP
      @members_only = true
      @group_name = "Members"
      @group_id = 'members'
    end

    @diff = params[:diff].present?
    @commit = params[:commit].present?
    @remove_group = params[:remove_group].presence || GoogleHelper::REMOVE_GROUP
    @use_remove_group = params[:use_remove_group].present? ? params[:use_remove_group] == 'true' : true
    @clear_remove_group = params[:clear_remove_group].present? ? params[:clear_remove_group] == 'true' : true
    @preview_only = params[:preview_only].present? ? params[:preview_only] == 'true' : false

    begin
      if(@commit)
        # Queue the sync job instead of running it directly
        GoogleGroupSyncJob.perform_later(
          @user.email,
          @group_email,
          group_id: @group_id,
          members_only: @members_only,
          use_remove_group: @use_remove_group,
          remove_group: @remove_group,
          clear_remove_group: @clear_remove_group,
          add_only: params[:add_only].present?,
          preview_only: @preview_only
        )

        if @preview_only
          flash[:notice] = "Preview mode: Populating remove group #{@remove_group} without modifying #{@group_email}. Check the Rails logs to monitor progress."
        else
          flash[:notice] = "Group sync job has been queued for #{@group_email}. The sync will run in the background."
        end
        redirect_to google_group_sync_path(group_id: @group_id)
        return
      end

      if(@diff)
        diff_results = diff_group(auth: @auth, group: @group_email, group_model: @group, members_only: @members_only)
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
