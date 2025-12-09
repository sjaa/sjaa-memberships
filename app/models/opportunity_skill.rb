class OpportunitySkill < ApplicationRecord
  include SkillLevelable

  belongs_to :opportunity
  belongs_to :skill

  validates :opportunity_id, uniqueness: { scope: :skill_id }
end
