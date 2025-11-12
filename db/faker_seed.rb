require_relative('./sjaa_port')

module FakerSeed
  include SjaaPort

  def rand_date(range = 20.years)
    DateTime.jd(rand(DateTime.now.ago(range).jd..DateTime.now.jd))
  end
  
  def rand_bool()
    rand(0..1) == 1
  end
  
  def generate_people(size: 100)
    # Default admins
    admins = {'read@sjaa.net' => [PERMISSION_HASH['read']], 'readwrite@sjaa.net' => [PERMISSION_HASH['read'], PERMISSION_HASH['write']]}
    
    # Only create them once
    admins.each do |email, permissions|
      admin = Admin.find_by(email: email)
      if(admin.nil?)
        admin = Admin.create(email: email, password: 'secret')
        admin.permissions = permissions
      end
    end
    
    referrals = {'internet' => 'Web search', 'friend' => 'Referred from a friend', 'school' => 'From a class at school'}.map{|name, desc| Referral.find_or_create_by(name: name, description: desc)}
    states = {'CA' => 'California', 'AZ' => 'Arizona', 'IL' => 'Illinois'}.map{|s,n| State.find_or_create_by(name: n, short_name: s)}
    kinds = [nil, MembershipKind.find_or_create_by(name: 'VB-M'), MembershipKind.find_or_create_by(name: 'LIFETIME'), nil, nil]
    instrument_kind = %w(telescope mount camera binocular)
    instrument_model = ['ASI2600MC', 'MEADE LX5000', 'CELESTRON AVX14', 'STELLARVUE 80ST', 'ASKAR 50MM', 'CELESTRON 10x50']
    instruments = instrument_kind.product(instrument_model).map{|kind, model| Instrument.find_or_create_by(kind: kind, model: model)}
    groups = {'SJAA Observers' => Faker::Internet.email, 'SJAA Imagers' => Faker::Internet.email, 'SJAA Board' => Faker::Internet.email, 'Member' => nil, 'Expired' => nil}.map{|n,e| Group.find_or_create_by(name: n, email: e, short_name: n.split(' ').map(&:first).join.upcase)}
    phase_names = %w(offered received letter consigned sold)
    
    # Generate 100 people
    size.times do 
      # Random Person
      discord = nil
      if(rand_bool)
        discord = rand(0..400000)
      end
      
      astrobin = nil
      if(rand_bool)
        astrobin = Astrobin.create(username: Faker::Lorem.word, latest_image: rand(0..400000))
      end
      
      person = Person.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      notes: Faker::Quotes::Shakespeare.hamlet_quote,
      referral: referrals.sample,
      discord_id: discord,
      astrobin: astrobin,
      )
      
      # with random memberships
      # TODO: Use person.update with membership_attrs: {} to get consistent
      #   behavior for LIFETIME memberships
      rand(1..10).times do |i|
        person.memberships << Membership.create(
        start: rand_date,
        term_months: 12,
        ephemeris: rand_bool,
        kind: kinds.sample,
        )
      end
      
      # and random contacts
      rand(1..3).times do |i|
        person.contacts << Contact.create(
        address: Faker::Address.street_address,
        city: City.find_or_create_by(name: Faker::Address.city),
        state: states.sample,
        zipcode: Faker::Address.zip,
        phone: Faker::PhoneNumber.phone_number,
        email: Faker::Internet.email,
        primary: i==0,
        )
        
        interests = []
        rand(0..INTEREST_LIST.values.size-1).times do
          interests << INTEREST_LIST.values.sample
        end
        person.interests = interests.uniq
        
        rand(0..5).times do 
          person.equipment << Equipment.find_or_create_by(instrument: instruments.sample, note: Faker::Lorem.sentence)
        end
        
        pgroups = []
        rand(0..2).times do
          pgroups << groups.sample
        end
        person.groups << pgroups.uniq
        
        rand(0..5).times do
          donation = Donation.create(
          name: "#{rand_date.jd}#{person.first_name[0].upcase}#{person.last_name[0].upcase}",
          note: Faker::Lorem.sentence,
          )
          
          # N Items to donate
          rand(0..4).times do
            di = DonationItem.create(
            equipment: Equipment.create(instrument: instruments.sample, note: Faker::Lorem.sentence),
            value: rand(0..1000),
            )
            
            # Phases
            di.phases = rand(0..4).times.map{|i| phase_names.sample}.uniq.map{|name| DonationPhase.create(name: name, date: rand_date, person: Person.all.sample)}
            
            donation.items << di
          end
          
          person.donations << donation
        end
      end
    end
  end
end