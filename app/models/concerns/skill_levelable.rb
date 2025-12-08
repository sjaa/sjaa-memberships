module SkillLevelable
  extend ActiveSupport::Concern

  included do
    # Skill level enum: 0 = None, 1 = Beginner, 2 = Intermediate, 3 = Advanced
    # Uses _prefix to avoid conflicts with ActiveRecord's built-in methods
    enum skill_level: {
      none: 0,
      beginner: 1,
      intermediate: 2,
      advanced: 3
    }, _prefix: :skill

    validates :skill_level, inclusion: { in: skill_levels.keys }
  end

  # Human-readable skill level name
  def skill_level_name
    skill_level&.titleize || "None"
  end

  # Check if this skill level represents active participation
  def active?
    !skill_none?
  end
end
