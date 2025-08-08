require 'google/api_client/client_secrets'

class GoogleController < ApplicationController
  append_before_action :set_auth
  include GoogleHelper

  def members
    if(@auth.nil?)
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to google_auth_path
      return
    end

    @diff = params[:diff].present?
    @commit = params[:commit].present?

    if(@commit)
      diff_results = sync(auth: @auth, save: true)
    end

    if(@diff)
      diff_results ||= diff_members_group(auth: @auth)
      @group_matched = diff_results[:group_matched]
      @unmatched_people = diff_results[:unmatched_people]
      @group_unmatched = diff_results[:group_unmatched]
    else
      @members = get_members(auth: @auth)
    end # if diff
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
