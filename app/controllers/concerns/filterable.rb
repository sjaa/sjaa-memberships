
module Filterable
  extend ActiveSupport::Concern
  include Sanitizable

  def tokenize(str)
    # The regex matches either a quoted phrase (including contents) OR
    # a sequence of non-whitespace characters (\\S+).  Don't include the quotes
    str.scan(/"(?:\\"|[^"])*"|\S+/).map{|token| token.gsub(/"/, '')}
  end

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
      logger.info("[AND_OR_HELPER] _models.query: #{_models.to_sql}, _models.count: #{_models.count}")
      _models = _models.select do |_model|
        list_ids = list.map(&:to_i)
        model_ids = _model.association(field).reader.map(&:id)
        logger.info("[AND_OR_HELPER] model: #{_model.id}, list_ids: #{list_ids.inspect}, model_ids: #{model_ids.inspect}")

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
      :search, :has_astrobin, :has_telescopius, :astrobin_username, :telescopius_username, :group_operation, :interest_operation, :skill_operation, :first_name, :last_name, :email, :phone, :city, :state, :ephemeris, :active, :volunteer, :mentor, :discord_id, interests: [], groups: [], skills: []
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
      skills = Skill.arel_table
      query = Person.left_joins(:contacts).left_joins(:skills)
      terms = nil
      tokens = tokenize(qp[:search])

      tokens.each_with_index do |term, i|
        # If the term has multiple words, assume it is first and last name
        subterms = term.split(/\s+/)
        first_name_query = people[:first_name].matches("%#{subterms.first}%")
        query = i == 0 ? query.where(first_name_query) : query.or(Person.where(first_name_query))

        # When there's a last name, we want an "and" match
        if(subterms.length > 1)
          query = query.where(people[:last_name].matches("%#{subterms.last}%"))
        else
          query = query.or(Person.where(people[:last_name].matches("%#{subterms.last}%")))
        end

        query = query.or(Person.where(contacts[:email].matches("%#{term}%")))
        query = query.or(Person.where(contacts[:phone].matches("%#{term}%")))
        query = query.or(Person.where(skills[:name].matches("%#{term}%")))
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
    query = query.joins(:astrobin).where(Astrobin.arel_table[:username].matches("%#{qp[:astrobin_username]}%")) if(qp[:astrobin_username].present?)
    query = query.joins(:telescopius).where(Telescopius.arel_table[:username].matches("%#{qp[:telescopius_username]}%")) if(qp[:telescopius_username].present?)

    # Filter by has_astrobin - check both for non-null ID and non-blank username
    if(qp[:has_astrobin] == 'yes')
      query = query.joins(:astrobin).where.not(Astrobin.arel_table[:username].eq(nil)).where.not(Astrobin.arel_table[:username].eq(''))
    elsif(qp[:has_astrobin] == 'no')
      query = query.left_joins(:astrobin).where(Astrobin.arel_table[:username].eq(nil).or(Astrobin.arel_table[:username].eq('')))
    end

    # Filter by has_telescopius - check both for non-null ID and non-blank username
    if(qp[:has_telescopius] == 'yes')
      query = query.joins(:telescopius).where.not(Telescopius.arel_table[:username].eq(nil)).where.not(Telescopius.arel_table[:username].eq(''))
    elsif(qp[:has_telescopius] == 'no')
      query = query.left_joins(:telescopius).where(Telescopius.arel_table[:username].eq(nil).or(Telescopius.arel_table[:username].eq('')))
    end
    
    # Handle interests, groups, and skills specially
    query = and_or_helper(Person, query, qp[:interest_operation], :interests, qp[:interests]) if(qp[:interests].present?)
    query = and_or_helper(Person, query, qp[:group_operation], :groups, qp[:groups]) if(qp[:groups].present?)
    query = and_or_helper(Person, query, qp[:skill_operation], :skills, qp[:skills]) if(qp[:skills].present?)

    query = query.active_members.where(memberships: {ephemeris: true}) if(qp[:ephemeris] == 'printed')

    # Handle volunteer and mentor filters
    query = query.where(volunteer: true) if(qp[:volunteer] == 'yes')
    query = query.where(volunteer: false) if(qp[:volunteer] == 'no')
    query = query.where(mentor: true) if(qp[:mentor] == 'yes')
    query = query.where(mentor: false) if(qp[:mentor] == 'no')

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
    #@all_people = Person.where(id: query.map(&:id).uniq).includes(:donations, :memberships, :contacts, :interests, :groups)
    @all_people = query.includes(:donations, :memberships, :interests, :groups, :skills, :astrobin, :telescopius, contacts: [:city, :state])
    @totals = {total: @all_people.count}
    @pagy, @people = pagy(@all_people, limit: 40, params: qp)
  end
  
end