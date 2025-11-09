module ReportsHelper

  # membership_report
  #  date_range - a Ruby range representing the date range to report on
  #  new_members_only - filter to show only members with no previous membership
  def membership_report(date_range: nil, new_members_only: false)
    report = {}
    date_range ||= Date.today.beginning_of_month..Date.today.end_of_month

    # Find all the new memberships within the date range
    #  Returns a hash with the person as the key and the membership (array) as the value
    report[:new_memberships] = Membership.where(start: date_range).includes(:person).order(:start).group_by(&:person)

    # Find memberships per person with the latest start date less than the start of the date range
    #   Members whose previous membership is nil are new members``
    #   Returns a hash with the person_id as the key and the membership (array) as the value
    report[:previous_memberships] = Membership.where(person_id: report[:new_memberships].keys.map(&:id))
                                             .group(:person_id, :id)
                                             .having('MAX(start) < ?', date_range.begin)
                                             .group_by(&:person_id)

    # Filter to only brand new members if requested
    if new_members_only
      brand_new_people = report[:new_memberships].keys.reject { |person| report[:previous_memberships].key?(person.id) }
      report[:new_memberships] = report[:new_memberships].slice(*brand_new_people)
    end

    # Calculate total donations for new memberships
    report[:total_donations] = report[:new_memberships].values.flatten.sum{ |membership| membership.donation_amount || 0 }

    # Skip computing lost memberships and overall counts when filtering for new members only
    unless new_members_only
      # Find all expired memberships within the date range
      report[:expired_memberships] = Membership.where(end: date_range).includes(:person).
                                       order(:end).group_by(&:person)

      # Find members who had expired memberships and did not renew
      still_active_expired = Person.where(id: report[:expired_memberships].keys.map(&:id)).active_members(date_range.end).uniq
      actually_lost_people = report[:expired_memberships].keys - still_active_expired
      report[:lost_memberships] = report[:expired_memberships].slice(*actually_lost_people)

      # Get first membership start date for lost members (for Memberships Lost table)
      report[:first_memberships_lost] = Membership.where(person_id: report[:lost_memberships].keys.map(&:id))
                                                  .group(:person_id)
                                                  .minimum(:start)

      report[:starting_count] = Person.active_members(date_range.begin).uniq.count
      #report[:starting_members] = Person.active_members(date_range.begin).uniq
      report[:ending_count] = Person.active_members(date_range.end).uniq.count
      #report[:ending_members] = Person.active_members(date_range.end).uniq
    else
      # Provide empty/default values when filtering
      report[:lost_memberships] = {}
      report[:first_memberships_lost] = {}
      report[:starting_count] = 0
      report[:ending_count] = 0
    end

    # Get first membership start date for new members (for Memberships Gained table)
    report[:first_memberships_gained] = Membership.where(person_id: report[:new_memberships].keys.map(&:id))
                                                  .group(:person_id)
                                                  .minimum(:start)

    return report
  end

  # to_csv
  #
  # Generate a CSV with the input models.  Optionally
  # provide a list of attributes to include.  Defaults
  # to all attributes
  def to_csv(models: [], attrs: [])
    sample = models.first
    return nil if(sample.nil?)

    _attrs = attrs&.empty? ? sample.attributes.keys : attrs

    CSV.generate(headers: true) do |csv|
      csv << _attrs
      models.each do |model|
        csv << _attrs.map{ |attr| model.attributes[attr] }
      end
    end
  end
end