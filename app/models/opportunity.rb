class Opportunity < ApplicationRecord
  has_many :opportunity_skills, dependent: :destroy
  has_many :skills, through: :opportunity_skills

  validates :title, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  # Get opportunities matching a person's skills
  # Returns array of [opportunity, full_match_count, partial_match_count]
  def self.for_person(person)
    return all.map { |o| [o, 0, 0] } if person.nil? || person.active_skills.empty?

    person_skill_map = person.people_skills.includes(:skill).each_with_object({}) do |ps, hash|
      hash[ps.skill_id] = ps.skill_level_before_type_cast
    end

    all.includes(:opportunity_skills, :skills).map do |opportunity|
      full_match_count = 0
      partial_match_count = 0

      opportunity.opportunity_skills.each do |os|
        person_level = person_skill_map[os.skill_id] || 0
        if person_level > 0
          if person_level >= os.skill_level_before_type_cast
            full_match_count += 1
          else
            partial_match_count += 1
          end
        end
      end

      [opportunity, full_match_count, partial_match_count]
    end.sort_by { |_, full, partial| [-full, -partial] }
  end

  # Check if a person meets the skill requirements
  def matches_person?(person)
    return false if person.nil? || opportunity_skills.empty?

    person_skill_map = person.people_skills.includes(:skill).each_with_object({}) do |ps, hash|
      hash[ps.skill_id] = ps.skill_level_before_type_cast
    end

    opportunity_skills.all? do |os|
      person_level = person_skill_map[os.skill_id] || 0
      person_level >= os.skill_level_before_type_cast
    end
  end

  # Accept nested attributes for opportunity_skills
  def skills_attributes=(attributes)
    # Clear existing associations
    opportunity_skills.destroy_all

    # Create new associations
    attributes.each do |attr|
      skill_id = attr[:skill_id] || attr['skill_id']
      skill_level = attr[:skill_level] || attr['skill_level']

      next if skill_id.blank?

      # Convert to integer and skip if 0 (none)
      level_int = skill_level.to_i
      next if level_int == 0

      opportunity_skills.build(
        skill_id: skill_id,
        skill_level: level_int
      )
    end
  end
end
