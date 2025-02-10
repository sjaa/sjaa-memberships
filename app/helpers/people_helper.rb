module PeopleHelper
  def filter(_qp = nil)
    if(_qp.nil?)
      @query_params = params.dup
      @query_params.delete(:authenticity_token)
      @query_params.delete(:submit)
      @query_params.select!{|k,v| v.present?}
      @query_params = @query_params.permit(
      :role_operation, :interest_operation, :first_name, :last_name, :email, :phone, :city, :state, :ephemeris, interests: [], roles: []
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
    
    # Handle Ephemeris specially
    if(qp[:ephemeris].present? && qp[:ephemeris] != 'either')
      _people = Person.where(id: query.map(&:id).uniq).includes(:memberships)
      if(qp[:ephemeris] == 'printed')
        _people = _people.select{|p| p.active_membership.first&.ephemeris}
      else
        _people = _people.select{|p| !p.active_membership.first&.ephemeris}
      end
      
      query = Person.where(id: _people)
    end
    
    @all_people = Person.where(id: query.map(&:id).uniq).includes(:donations, :memberships, :contacts, :interests, :roles)
    @pagy, @people = pagy(@all_people, limit: 40, params: qp)
  end
  
end