module GoogleHelper
  MEMBERS_GROUP = 'members@sjaa.net'
  REMOVE_GROUP = 'expired-members@sjaa.net'

  def sync(auth: nil, save: true)
    # Compute diff
    diff = diff_members_group(auth: auth)
    client = diff[:client]

    # Optionally save off all removed members in a temporary group
    if(save)
      members = get_members(client: client, group: REMOVE_GROUP)
      members.each do |member|
        client.delete_member(REMOVE_GROUP, member.email)
      end

      # Add the to-be-removed members to a new group
      diff[:group_unmatched].each do |mh|
        client.insert_member(REMOVE_GROUP, Google::Apis::AdminDirectoryV1::Member.new(email: mh[:email]))
      end
    end

    # Remove the unmatched people from the member's group
    diff[:group_unmatched].each do |mh|
      client.delete_member(MEMBERS_GROUP, mh[:email])
    end

    # Add the missing people
    diff[:unmatched_people].each do |person|
      client.insert_member(MEMBERS_GROUP, Google::Apis::AdminDirectoryV1::Member.new(email: person.email)) if(person.email.present?)
    end

    return diff
  end

  def diff_members_group(auth: nil)
    results = {
    }

    # Get a client from googleapis
    client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client.authorization = auth
    members = get_members(client: client)
    results[:client] = client

    # Diff Members
    active_people = Person.all.includes(:contacts).joins(:memberships).active_members.uniq.to_a #Person
    matched_people = []
    results[:group_matched] = [] # {person: p, member: member}
    group_unmatched = members # Member
    
    # Iterate through active members, and find their e-mail addresses in the Google Group
    #   Subtract all the found members from the group_unmatched list, and from the active_people list
    #   Add found members to the "group_matched"
    active_people.each do |person|
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

    results[:unmatched_people] = active_people - matched_people

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
