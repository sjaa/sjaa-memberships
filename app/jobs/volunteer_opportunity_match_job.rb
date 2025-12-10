class VolunteerOpportunityMatchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Find all people who have opted to be volunteers and are active members
    volunteers = Person.where(volunteer: true).select(&:is_active?)

    volunteers.each do |person|
      # Skip if person has no email
      next if person.email.blank?

      # Get active opportunities with match information
      opportunities_with_matches = Opportunity.active.for_person(person)

      # Separate into different categories
      full_matches = []        # All skills met at required level
      partial_matches = []     # Some skills match but not all requirements met
      no_skill_required = []   # Opportunities with no skill requirements

      opportunities_with_matches.each do |opportunity, full_count, partial_count|
        # Opportunities with no required skills - anyone can apply
        if opportunity.opportunity_skills.empty?
          no_skill_required << opportunity
          next
        end

        total_required = opportunity.opportunity_skills.count

        # Full match: all skills met at required level
        if full_count == total_required
          full_matches << opportunity
        # Partial match: at least one skill matches but not all requirements met
        elsif full_count > 0 || partial_count > 0
          partial_matches << opportunity
        end
      end

      # Always send email to volunteers (even if no matches)
      AccountMailer.volunteer_opportunity_matches(
        person,
        full_matches,
        partial_matches,
        no_skill_required
      ).deliver_now

      # Self-imposed rate-limiting to avoid overwhelming mail server
      sleep(1)
    end
  end
end
