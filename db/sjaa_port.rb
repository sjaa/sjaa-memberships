module SjaaPort
  require('csv')
  def not_empty(str)
    return str && !str&.strip&.empty?
  end
  
  def parse_date(date)
    begin
      return DateTime.strptime(date, '%m-%d-%y')
    rescue
      puts "[W] Could not form a date out of #{date}"
      return nil
    end
  end
  
  def parse_term(term, status)
    _term = term&.strip&.downcase
    _status = status&.strip&.downcase
    if(_term == 'life' && _status == 'member')
      return nil
    elsif(_term == '1yr' || _status == 'member')
      return 12
    else
      return 0
    end
  end
  
  # Fixed Values
  INTEREST_LIST = {}
  {
    'astrophotography' => '',
    'solar system' => '',
    'deep sky' => '',
    'science' => '',
    'history' => '',
    'solar' => '',
    'social' => '',
  }.each do |name, description|
    INTEREST_LIST[name] = Interest.find_or_create_by(name: name, description: description)
  end

  STATES = {}
  {
  'CA' => 'California',
  'AZ' => 'Arizona',
  }.each do |s, n|
    STATES[s] = State.find_or_create_by(name: n, short_name: s)
  end
  
  PERMISSION_HASH = {}
  %w(read write permit).each do |p|
  PERMISSION_HASH[p] = Permission.find_or_create_by(name: p)
  end
  
  def populate_contact(person, row, primary = true)
    Contact.new(
    address: row['Address1']&.strip,
    city: not_empty(row['City1']) ? City.find_or_create_by(name: row['City1'].titleize) : nil,
    state: not_empty(row['ST1']) ? State.where(short_name: row['ST1']&.strip&.upcase).first : nil,
    zipcode: not_empty(row['Zip1']) ? row['Zip1']&.strip : nil,
    phone: not_empty(row['phone1']) ? row['phone1']&.strip : nil,
    email: not_empty(row['email1']) ? row['email1']&.strip : nil,
    primary: primary,
    person: person,
    )
  end
  
  def populate_membership(person, row)
    # Membership for their latest payment
    start = parse_date(row['last payment'])
    term = parse_term(row['Term'], row['Status'])
    kind = term.nil? ? 'lifetime' : row['Type']
    
    membership = Membership.new(
    start: start,
    term_months: term,
    ephemeris: row['Ephem']&.strip == 'PRINT',
    kind: kind.present? ? MembershipKind.find_or_create_by(name: kind&.strip) : nil,
    donation_amount: (/(\d+)/.match(row['Cash?'])&.to_a || [])[1],
    person: person,
    )
    
    return membership
  end
  
  def parse_interest(row)
    interest_s = row['Interests']&.strip
    interest = nil
    if(interest_s)
      if(interest_s =~ /solar system/i) 
        interest = INTEREST_LIST['solar system']
      elsif(interest_s =~ /solar viewing/i) 
        interest = INTEREST_LIST['solar']
      elsif(interest_s =~ /deep sky/i) 
        interest = INTEREST_LIST['deep sky']
      elsif(interest_s =~ /astrophotography/i) 
        interest = INTEREST_LIST['astrophotography']
      elsif(interest_s =~ /history/i) 
        interest = INTEREST_LIST['history']
      elsif(interest_s =~ /meeting/i) 
        interest = INTEREST_LIST['social']
      elsif(interest_s =~ /science/i) 
        interest = INTEREST_LIST['science']
      end
    end
    
    return interest
  end
  
  # Use this to update records from the source (currently SJAA DB)
  #   Tries to find records before creating them...
  def patch(patch_file, commit=true)
    ActiveRecord::Base.transaction do
      CSV.foreach(Rails.root.join('db', patch_file), headers: true) do |row|
        # Look up person by e-mail
        person = Person.find_by_email(row['email1'])
        person ||= Person.find_by_email(row['email2'])

        # Look up person by name if email fails
        person ||= Person.find_or_create_by(first_name: row['First Name'], last_name: row['Last Name'])

        # Update Contact Info
        old_contact = person.contacts.find_by(primary: true)
        contact = populate_contact(person, row)

        old_contact.destroy if(old_contact)
        contact.save() 
        puts "[E] #{contact.errors.full_messages.join('  ')}" if(contact.errors.any?)
        contact.save(validate: false) if(contact.email.nil?)

        # Update Membership info
        membership = populate_membership(person, row)
        existing_membership = person.memberships.find_by(start: membership.start)
        membership.save if(existing_membership.nil?)

        # Membership for their first payment ("since")
        since = parse_date(row['Member Since'])
        if(since)
          Membership.create(start: since, term_months: 0, person: person) if(person.memberships.find_by(start: since).nil?)
        end
      end

      raise "Rolling back due to commit being false" if(!commit)
    end
  rescue => e
    puts "[W] Rolling back patch transactions due to exception:"
    puts e
  end
end