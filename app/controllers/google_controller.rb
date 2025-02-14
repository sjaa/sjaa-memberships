require 'google/api_client/client_secrets'

class GoogleController < ApplicationController
  append_before_action :set_auth

  def members
    if(@auth.nil?)
      flash[:alert] = 'You must authenticate with Google first.'
      redirect_to google_auth_path
      return
    end

    # Get a client from googleapis
    client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client.authorization = @auth
    get_members(client)
    @diff = params[:diff].present?

    if(@diff)
      active_people = Person.all.includes(:contacts).joins(:memberships).active_members.to_a #Person
      matched_people = []
      @group_matched = [] # {person: p, member: member}
      group_unmatched = @members # Member - TODO: Try to match these with people in the database
      
      # Iterate through active members, and find their e-mail addresses in the Google Group
      #   Subtract all the found members from the group_unmatched list, and from the active_people list
      #   Add found members to the "group_matched"
      active_people.each do |person|
        emails = person.contacts.map(&:email).select{|e| e.present?}
        emails.each do |email|
          member = group_unmatched.find{|mem| mem.email.downcase.strip == email.downcase.strip}
          if(member)
            group_unmatched.delete(member)
            @group_matched << {person: person, member: member}
            matched_people << person
          end
        end
      end
      @unmatched_people = active_people - matched_people

      # Fill in the group unmatched emails with a person
      unmatched_emails = group_unmatched.map(&:email)
      unmatched_contacts = Contact.where(email: unmatched_emails).includes(:person)
      unmatched_emails -= unmatched_contacts.map(&:email)
      unmatched_emails.select!{|email| email !~ /@sjaa.net/} # Remove sjaa.net accounts
      @group_unmatched = []
      unmatched_contacts.each{|contact| @group_unmatched << {person: contact.person, email: contact.email}}
      unmatched_emails.each{|email| @group_unmatched << {email: email}}
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

  def members_diff
  end

  private
  def set_auth
    # Make sure there's a valid refresh token available
    if(@user&.refresh_token.nil?)
      @auth = nil
      return
    end

    # Load client secrets
    cshash = JSON.parse Base64.decode64(ENV['GOOGLE_WEB_CLIENT_BASE64'])
    client_secrets = Google::APIClient::ClientSecrets.new cshash

    # Get the auth object
    auth = client_secrets.to_authorization
    auth.refresh_token = @user.refresh_token

    @auth = auth
  end

  def get_members(client)
    ret = client.list_members('members@sjaa.net')
    @members = ret.members
    while(ret.next_page_token)
      ret = client.list_members('members@sjaa.net', page_token: ret.next_page_token)
      @members += ret.members
    end
  end
end
