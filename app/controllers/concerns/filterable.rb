
module Filterable
  extend ActiveSupport::Concern
  include Sanitizable

  def and_or_helper(model, query, operation, field, list)
    list.select!{|l| l.present?}
    return query if(list.empty?)
    query = query.joins(field)

    #logger.info("model: #{model.to_s}, query: #{query.to_sql}, operation: #{operation}, field: #{field}, list: #{list.inspect}")
    
    if(operation != 'and')
      query = query.where(field => {id: list})
    else
      # Yucky rendering out all the people, but what else to do?
      _models = model.where(id: query.map(&:id).uniq).includes(field)
      #logger.info("_models.query: #{_models.to_sql}, _models.count: #{_models.count}")
      _models = _models.select do |_model|
        list_ids = list.map(&:to_i)
        model_ids = _model.association(field).reader.map(&:id)
        #logger.info("model: #{_model.attributes['name'] || _model.id}, list_ids: #{list_ids.inspect}, model_ids = #{model_ids}")

        (list_ids - model_ids).empty?
      end

      #logger.info("_models.size: #{_models.size}, _models.count: #{_models.count}")
      query = model.where(id: _models.map(&:id))
      
      # Alternative but relies on grouping
      #query = query.where(field => {id: list}).group(:id).having("COUNT(#{field}.id) >= ?", list.size)
    end
    
    return query
  end

  def people_filter(_qp = nil)
    if(_qp.nil?)
      @query_params = params.dup
      @query_params.delete(:authenticity_token)
      @query_params.delete(:submit)
      @query_params.select!{|k,v| v.present?}
      @query_params = @query_params.permit(
      :search, :has_astrobin, :role_operation, :interest_operation, :first_name, :last_name, :email, :phone, :city, :state, :ephemeris, :active, :discord_id, interests: [], roles: []
      )
      qp = @query_params.to_h
    else
      qp = _qp
    end
    
    qp = sanitize qp

    # Everything ORed with everything!
    if(qp[:search].present?)
      people = Person.arel_table
      contacts = Contact.arel_table
      query = Person.left_joins(:contacts)
      terms = nil

      qp[:search].split(' ').each_with_index do |term, i|
        first_name_query = people[:first_name].matches("%#{term}%")
        query = i == 0 ? query.where(first_name_query) : query.or(Person.where(first_name_query))
        query = query.or(Person.where(people[:last_name].matches("%#{term}%")))
        query = query.or(Person.where(contacts[:email].matches("%#{term}%")))
        query = query.or(Person.where(contacts[:phone].matches("%#{term}%")))
      end

      query = query.distinct
      logger.debug "[SEARCH] Query: #{query.to_sql}"
    else
      query = Person.all
    end

    query = query.where(discord_id: qp[:discord_id]) if(qp[:discord_id].present?)
    query = query.where(Person.arel_table[:first_name].matches("%#{qp[:first_name]}%")) if(qp[:first_name].present?)
    query = query.where(Person.arel_table[:last_name].matches("%#{qp[:last_name]}%")) if(qp[:last_name].present?)
    query = query.joins(:contacts).where(Contact.arel_table[:email].matches("%#{qp[:email]}%")) if(qp[:email].present?)
    query = query.joins(:contacts).where(Contact.arel_table[:phone].matches("%#{qp[:phone]}%")) if(qp[:phone].present?)
    query = query.joins(contacts: :city).where(City.arel_table[:name].matches("%#{qp[:city]}%")) if(qp[:city].present?)
    query = query.joins(contacts: :state).where(State.arel_table[:short_name].matches("%#{qp[:state]}%")) if(qp[:state].present?)
    query = query.where.not(astrobin_id: nil) if(qp[:has_astrobin] == 'true')
    
    # Handle interests and roles specially
    query = and_or_helper(Person, query, qp[:interest_operation], :interests, qp[:interests]) if(qp[:interests].present?)
    query = and_or_helper(Person, query, qp[:role_operation], :roles, qp[:roles]) if(qp[:roles].present?)
    
    query = query.active_members.where(memberships: {ephemeris: true}) if(qp[:ephemeris] == 'printed')
    
    # Do the active filter last, as this turns query into an Array
    if(qp[:active] == 'yes')
      # Subtract out the inactive people
      query = query.active_members
    elsif(qp[:active] == 'no')
      # Subtract out the active people
      query = query.inactive_members
    end
    
    @active_memberships = Person.common_active_membership_query(Membership.all).group_by{|m| m.person_id}
    #@active_memberships = query.active_members.group_by{|m| m.id}
    #@all_people = Person.where(id: query.map(&:id).uniq).includes(:donations, :memberships, :contacts, :interests, :roles)
    @all_people = query.includes(:donations, :memberships, :interests, :roles, :astrobin, contacts: [:city, :state])
    @totals = {total: @all_people.count}
    @pagy, @people = pagy(@all_people, limit: 40, params: qp)
  end
  
end