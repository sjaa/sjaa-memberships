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
    
    
    status = Status.find_or_create_by(
    name: row['Status']&.strip&.downcase || 'unknown'
    )
    
    astrobin = (not_empty(row['Astrobin Username'])) ? 
    Astrobin.create(username: row['Astrobin Username']&.strip, latest_image: row['Astrobin Last Posted Image']&.to_i) : 
    nil
    
    notes = row['Equipment'] ? "Equipment: #{row['Equipment']}" : ''
    notes = row['Cash?'] ? "#{notes} Donation: #{row['Cash?']}".strip : notes
    notes = nil if(notes.strip.empty?)
    
    person = Person.create(
    first_name: row['First Name'],
    last_name: row['Last Name'],
    status: status,
    discord_id: row['Discord ID']&.strip,
    astrobin: astrobin,
    notes: notes,
    )
    person.interests << interest if(interest)
    
    puts "[E] #{person.errors.full_messages.join('  ')}" if(person.errors.any?)
    
    Contact.create(
    address: row['Address1']&.strip,
    city: not_empty(row['City1']) ? City.find_or_create_by(name: row['City1'].titleize) : nil,
    state: not_empty(row['ST1']) ? State.where(short_name: row['ST1']&.strip&.upcase).first : nil,
    zipcode: not_empty(row['Zip1']) ? row['Zip1']&.strip : nil,
    phone: not_empty(row['phone1']) ? row['phone1']&.strip : nil,
    email: not_empty(row['email1']) ? row['email1']&.strip : nil,
    primary: true,
    person: person,
    )
    
    if(not_empty(row['email2']) || not_empty(row['phone2']))
      Contact.create(
      email: not_empty(row['email2']) ? row['email2']&.strip : nil,
      phone: not_empty(row['phone2']) ? row['phone2']&.strip : nil,
      person: person,
      )
    end
    
    # Membership for their latest payment
    membership = Membership.create(
    start: start,
    term_months: row['Term']&.strip == '1yr' ? 12 : nil,
    ephemeris: row['Ephem']&.strip == 'PRINT',
    new: row['New/Rtn']&.strip == 'New',
    kind: row['Type']&.strip,
    person: person,
    )
    
    # Membership for their first payment ("since")
    since = parse_date(row['Member Since'])
    if(since)
      Membership.create(start: since, new: true, person: person)
    end
  end
end
end