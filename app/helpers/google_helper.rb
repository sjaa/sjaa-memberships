require 'google/api_client/client_secrets'

module GoogleHelper
  MEMBERS_GROUP = ENV.fetch('GOOGLE_MEMBERS_GROUP', 'membership-app-test-group@sjaa.net')
  REMOVE_GROUP = ENV.fetch('GOOGLE_REMOVE_GROUP', 'expired-members@sjaa.net')

  def get_auth(user)
    # Make sure there's a valid refresh token available
    if(user&.refresh_token.nil?)
      return nil
    end

    # Load client secrets
    cshash = JSON.parse Base64.decode64(ENV['GOOGLE_WEB_CLIENT_BASE64'])
    client_secrets = Google::APIClient::ClientSecrets.new cshash

    # Get the auth object
    auth = client_secrets.to_authorization
    auth.refresh_token = user.refresh_token

    return auth
  end

  def sync(auth: nil, group: MEMBERS_GROUP, role: nil, members_only: true, save: true, add_only: false)
    # Compute diff
    diff = diff_group(auth: auth, group: group, role: role, members_only: members_only)
    client = diff[:client]
    diff[:errors] ||= []

    # Optionally save off all removed members in a temporary group
    if(save)
      members = get_members(client: client, group: REMOVE_GROUP)
      members.each do |member|
        begin
          client.delete_member(REMOVE_GROUP, member.email)
        rescue
          puts "[W] Skipping delete of #{member.inspect} from #{REMOVE_GROUP}"
        end
      end

      # Add the to-be-removed members to a new group
      diff[:group_unmatched].each do |mh|
        begin
          client.insert_member(REMOVE_GROUP, Google::Apis::AdminDirectoryV1::Member.new(email: mh[:email]))
        rescue => e
          diff[:errors] << {source: :remove, email: mh[:email], error: e}
        end
      end
    end

    # Remove the unmatched people from the target group
    unless(add_only)
      diff[:group_unmatched].each do |mh|
        begin
          client.delete_member(group, mh[:email])
        rescue
          puts "[W] Skipping delete of #{mh.inspect} from #{group}"
        end
      end
    end

    # Add the missing people
    diff[:unmatched_people].each do |person|
      begin
        client.insert_member(group, Google::Apis::AdminDirectoryV1::Member.new(email: person.email)) if(person.email.present?)
      rescue => e
        diff[:errors] << {source: :add, email: person.email, error: e}
      end
    end

    return diff
  end

  # Generic method to diff any group with role membership or active members
  def diff_group(auth: nil, group: MEMBERS_GROUP, role: nil, members_only: true)
    results = {}

    # Get a client from googleapis
    client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client.authorization = auth
    members = get_members(client: client, group: group)
    results[:client] = client

    # Determine which people should be in the group
    if role
      # Get people in this role
      query = Person.includes(:contacts).joins(:roles).where(roles: {id: role.id}).distinct
      puts "[DEBUG] Role query SQL: #{query.to_sql}"
      people = query.to_a
      puts "[DEBUG] Found #{people.count} people in role #{role.name} (id: #{role.id})"

      # If members_only is true, filter to only active members
      if members_only
        people = people.select(&:is_active?)
        puts "[DEBUG] After filtering for active members: #{people.count} people"
      end
    else
      # Default behavior: active members only
      people = Person.all.includes(:contacts).joins(:memberships).active_members.distinct.to_a
    end

    matched_people = []
    results[:group_matched] = [] # {person: p, member: member}
    group_unmatched = members # Member
    
    # Iterate through people, and find their e-mail addresses in the Google Group
    #   Subtract all the found members from the group_unmatched list, and from the people list
    #   Add found members to the "group_matched"
    people.each do |person|
      emails = person.contacts.map(&:email).select{|e| e.present?}
      emails.each do |email|
        member = group_unmatched.find do |mem| 
          _email = email.downcase.strip
          _left = mem.email.downcase.strip

          # GMAIL Addresses don't count periods, so remove them
          if(_email =~ /gmail.com/)
            _email.gsub!('.', '')
            _left.gsub!('.', '')
          end

          _left == _email
        end

        if(member)
          group_unmatched.delete(member)
          results[:group_matched] << {person: person, member: member}
          matched_people << person
        end
      end
    end

    results[:unmatched_people] = people - matched_people

    # Fill in the group unmatched emails with a person
    unmatched_emails = group_unmatched.map(&:email).map(&:downcase)
    unmatched_contacts = Contact.where('lower(email) IN (?)', unmatched_emails).includes(:person)
    unmatched_emails -= unmatched_contacts.map(&:email).map(&:downcase)
    unmatched_emails.select!{|email| email !~ /@sjaa.net/} # Remove sjaa.net accounts
    group_unmatched = []
    unmatched_contacts.each{|contact| group_unmatched << {person: contact.person, email: contact.email}}
    unmatched_emails.each{|email| group_unmatched << {email: email}}
    results[:group_unmatched] = group_unmatched

    return results
  end

  # Backwards compatibility wrapper
  def diff_members_group(auth: nil)
    diff_group(auth: auth, group: MEMBERS_GROUP, role: nil, members_only: true)
  end

  def get_members(auth: nil, client: nil, group: MEMBERS_GROUP)
    if(client.nil?)
      client = Google::Apis::AdminDirectoryV1::DirectoryService.new
      client.authorization = auth
    end

    ret = client.list_members(group)
    members = ret.members
    while(ret.next_page_token)
      ret = client.list_members(group, page_token: ret.next_page_token)
      members += ret.members
    end

    return members || []
  end
end
