module PeopleHelper
  def and_or_helper(query, operation, field, list)
    list.select!{|l| l.present?}
    return query if(list.empty?)
    query = query.joins(field)
    
    if(operation != 'and')
      query = query.where(field => {id: list})
    else
      # Yucky rendering out all the people, but what else to do?
      _people = Person.where(id: query.map(&:id).uniq).includes(field)
      _people = _people.select{|p| (list.map(&:to_i) - p.association(field).reader.map(&:id)).empty?}
      query = Person.where(id: _people.map(&:id))
      
      # Alternative but relies on grouping
      #query = query.where(field => {id: list}).group(:id).having("COUNT(#{field}.id) >= ?", list.size)
    end
    
    return query
  end
  
  def filter(_qp = nil)
    if(_qp.nil?)
      @query_params = params.dup
      @query_params.delete(:authenticity_token)
      @query_params.delete(:submit)
      @query_params.select!{|k,v| v.present?}
      @query_params = @query_params.permit(
      :role_operation, :interest_operation, :first_name, :last_name, :email, :phone, :city, :state, :ephemeris, :active, interests: [], roles: []
      )
      qp = @query_params.to_h
    else
      qp = _qp
    end
    
    query = Person.all
    query = query.where(Person.arel_table[:first_name].matches("%#{qp[:first_name]}%")) if(qp[:first_name].present?)
    query = query.where(Person.arel_table[:last_name].matches("%#{qp[:last_name]}%")) if(qp[:last_name].present?)
    query = query.joins(:contacts).where(Contact.arel_table[:email].matches("%#{qp[:email]}%")) if(qp[:email].present?)
    query = query.joins(:contacts).where(Contact.arel_table[:phone].matches("%#{qp[:phone]}%")) if(qp[:phone].present?)
    query = query.joins(contacts: :city).where(City.arel_table[:name].matches("%#{qp[:city]}%")) if(qp[:city].present?)
    query = query.joins(contacts: :state).where(State.arel_table[:short_name].matches("%#{qp[:state]}%")) if(qp[:state].present?)
    
    # Handle interests and roles specially
    query = and_or_helper(query, qp[:interest_operation], :interests, qp[:interests]) if(qp[:interests].present?)
    query = and_or_helper(query, qp[:role_operation], :roles, qp[:roles]) if(qp[:roles].present?)
    
    query = query.active_members.where(memberships: {ephemeris: true}) if(qp[:ephemeris] == 'printed')
    
    # Do the active filter last, as this turns query into an Array
    if(qp[:active] == 'yes')
      # Subtract out the inactive people
      query = query - Person.inactive_members
    elsif(qp[:active] == 'no')
      # Subtract out the active people
      query = query - Person.active_members
    end
    
    @active_memberships = Person.common_active_membership_query(Membership.all).group_by{|m| m.person_id}
    @all_people = Person.where(id: query.map(&:id).uniq).includes(:donations, :memberships, :contacts, :interests, :roles)
    @totals = {total: @all_people.count}
    @pagy, @people = pagy(@all_people, limit: 40, params: qp)
  end
  
  def people_to_sjaa_db(people)
    csv = CSV.generate(headers: true) do |csv|
      csv << ["First Name", "Last Name", "Status", "Expiry Date", 
      "last payment", 'Cash?', 'Term', 
      'Type', 'New/Rtn', 'Member Since', 'Ephem', 'Comp', 'email1', 
      'Address1', 'City1', 'ST1', 'Zip1', 'phone1', 'email2', 'phone2', 
      "Observer's Group?", "Observers Email Address (if diff)", "Interests", "Equipment"]


      people.each do |person|
        term = person.latest_membership&.term_years
        csv << [
          person.first_name, person.last_name, person.is_active? ? 'Member' : 'Expired', person.latest_membership&.end&.strftime('%m-%d-%Y') || 'Life', 
          person.latest_membership&.start&.strftime('%m-%d-%Y') || '', '',  term ? "#{term}yr" : '',
          person.latest_membership&.kind&.name, person.latest_membership == person.first_membership ? 'New' : 'Rtn', person.first_membership&.start&.strftime('%m-%d-%Y') || '', person.latest_membership&.ephemeris ? 'PRINT' : '', person.latest_membership&.end.nil? ? 'Lifetime' : '', person.contacts.first&.email || '',
          person.contacts.first&.address || '', person.contacts.first&.city&.name || '', person.contacts.first&.state&.short_name || '', person.contacts.first&.zipcode || '', person.contacts.first&.phone || '', person.contacts.second&.email || '', person.contacts.second&.phone || '',
          '', '', person.interests.map(&:name).join(", "), person.notes
        ]
      end
    end

    csv
  end
end