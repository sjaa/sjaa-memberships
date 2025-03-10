module SjaaPort
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
  INTEREST_LIST[name] = Interest.create(name: name, description: description)
end

STATES = {}
{
'CA' => 'California',
'AZ' => 'Arizona',
}.each do |s, n|
  STATES[s] = State.create(name: n, short_name: s)
end

PERMISSION_HASH = {}
%w(read write permit).each do |p|
  PERMISSION_HASH[p] = Permission.create(name: p)
end

def port()
  require('csv')
  CSV.foreach(Rails.root.join('db', 'seeds.csv'), headers: true) do |row|
    puts "[I] processing row: #{row}"
    
    # Headers are...
    #   First Name,Last Name,Status,Expiry Date,last payment,Cash?,Term,Type,New/Rtn,Member Since,Ephem,Comp,email1,Address1,City1,ST1,Zip1,phone1,email2,phone2,Observer's Group?,Observers Email Address (if diff),Interests,Equipment,Discord ID,Astrobin Username,Astrobin Last Posted Image
    start = parse_date(row['last payment'])
    
    # Parse interests
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
    
    
    astrobin = (not_empty(row['Astrobin Username'])) ? 
    Astrobin.create(username: row['Astrobin Username']&.strip, latest_image: row['Astrobin Last Posted Image']&.to_i) : 
    nil
    
    notes = row['Equipment'] ? "Equipment: #{row['Equipment']}" : ''
    notes = row['Cash?'] ? "#{notes} Donation: #{row['Cash?']}".strip : notes
    notes = nil if(notes.strip.empty?)
    
    person = Person.create(
    first_name: row['First Name'],
    last_name: row['Last Name'],
    discord_id: row['Discord ID']&.strip,
    astrobin: astrobin,
    notes: notes,
    )
    person.interests << interest if(interest)
    
    puts "[E] #{person.errors.full_messages.join('  ')}" if(person.errors.any?)
    
    c = Contact.create(
    address: row['Address1']&.strip,
    city: not_empty(row['City1']) ? City.find_or_create_by(name: row['City1'].titleize) : nil,
    state: not_empty(row['ST1']) ? State.where(short_name: row['ST1']&.strip&.upcase).first : nil,
    zipcode: not_empty(row['Zip1']) ? row['Zip1']&.strip : nil,
    phone: not_empty(row['phone1']) ? row['phone1']&.strip : nil,
    email: not_empty(row['email1']) ? row['email1']&.strip : nil,
    primary: true,
    person: person,
    )
    
    puts "[E] #{c.errors.full_messages.join('  ')}" if(c.errors.any?)
    c.save(validate: false) if(c.email.nil?)
    
    if(not_empty(row['email2']) || not_empty(row['phone2']))
      c = Contact.create(
      email: not_empty(row['email2']) ? row['email2']&.strip : nil,
      phone: not_empty(row['phone2']) ? row['phone2']&.strip : nil,
      person: person,
      )
      puts "[E] #{c.errors.full_messages.join('  ')}" if(c.errors.any?)
      c.save(validate: false) if(c.email.nil?)
    end
    
    if(row['Observers Email Address (if diff)'].present?)
      c = Contact.create(
      email: row['Observers Email Address (if diff)']&.strip,
      person: person,
      )
      puts "[E] #{c.errors.full_messages.join('  ')}" if(c.errors.any?)
      c.save(validate: false) if(c.email.nil?)
    end
    
    # Membership for their latest payment
    term = parse_term(row['Term'], row['Status'])
    kind = term.nil? ? 'lifetime' : row['Type']
    membership = Membership.create(
    start: start,
    term_months: term,
    ephemeris: row['Ephem']&.strip == 'PRINT',
    kind: kind.present? ? MembershipKind.find_or_create_by(name: kind&.strip) : nil,
    donation_amount: (/(\d+)/.match(row['Cash?'])&.to_a || [])[1],
    person: person,
    )
    
    # Membership for their first payment ("since")
    since = parse_date(row['Member Since'])
    if(since)
      Membership.create(start: since, term_months: 0, person: person)
    end
  end
end
end