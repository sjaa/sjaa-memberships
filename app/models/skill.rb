class Skill < ApplicationRecord
  has_many :people_skills, dependent: :destroy
  has_many :people, through: :people_skills

  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

  before_validation :normalize_name

  # Generate email based on skill name pattern: skills-[skill-name]@sjaa.net
  def generate_email
    return if name.blank?
    normalized = name.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/(^-|-$)/, '')
    "skills-#{normalized}@sjaa.net"
  end

  # Get all people with this skill who have indicated interest or skill level > 0
  def active_members
    people.joins(:people_skills)
          .where('people_skills.skill_id = ? AND (people_skills.skill_level > 0 OR people_skills.interest_level > 0)', id)
  end

  # Get people who are active members of SJAA
  def active_sjaa_members
    active_members.select(&:is_active?)
  end

  private

  def normalize_name
    self.name = name.strip if name.present?
  end
end
