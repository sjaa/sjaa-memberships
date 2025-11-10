class PeopleSkill < ApplicationRecord
  include GoogleHelper

  belongs_to :person
  belongs_to :skill

  # Skill level enum: 0 = None, 1 = Beginner, 2 = Intermediate, 3 = Advanced
  enum skill_level: {
    none: 0,
    beginner: 1,
    intermediate: 2,
    advanced: 3
  }, _prefix: :skill

  validates :person_id, uniqueness: { scope: :skill_id }
  validates :skill_level, inclusion: { in: skill_levels.keys }

  # Callback to sync with Google Groups when skill levels change
  after_commit :sync_to_google_group, on: [:create, :update, :destroy]

  # Check if this person-skill combination represents an active participation
  def active?
    !skill_none?
  end

  # Human-readable skill level name
  def skill_level_name
    skill_level&.titleize || "None"
  end

  private

  def sync_to_google_group
    return unless skill.email.present?
    return unless person.email.present?
    return unless person.is_active? # Only sync active SJAA members

    # Find an admin with Google credentials for syncing
    admin = Admin.where.not(refresh_token: nil).first
    return unless admin&.refresh_token.present?

    begin
      # Get Google API authorization
      auth = get_auth(admin)
      client = Google::Apis::AdminDirectoryV1::DirectoryService.new
      client.authorization = auth

      # Determine if we should add or remove this person from the group
      if destroyed? || !active?
        # Remove from group
        begin
          client.delete_member(skill.email, person.email)
          Rails.logger.info "[PeopleSkill] Removed #{person.email} from #{skill.email}"
        rescue Google::Apis::ClientError => e
          if e.status_code == 404 || e.message.include?("Resource Not Found") || e.message.include?("notFound")
            Rails.logger.info "[PeopleSkill] #{person.email} already not in #{skill.email}"
          else
            Rails.logger.error "[PeopleSkill] Failed to remove #{person.email}: #{e.message}"
          end
        end
      else
        # Add to group
        begin
          member = Google::Apis::AdminDirectoryV1::Member.new(
            email: person.email,
            role: 'MEMBER',
            type: 'USER'
          )
          client.insert_member(skill.email, member)
          Rails.logger.info "[PeopleSkill] Added #{person.email} to #{skill.email}"
        rescue Google::Apis::ClientError => e
          if e.status_code == 409 || e.message.include?("Member already exists")
            Rails.logger.info "[PeopleSkill] #{person.email} already in #{skill.email}"
          else
            Rails.logger.error "[PeopleSkill] Failed to add #{person.email}: #{e.message}"
          end
        end
      end
    rescue => e
      Rails.logger.error "[PeopleSkill] Google Groups sync error: #{e.class.name} - #{e.message}"
      # Don't raise - we don't want to fail the save if Google sync fails
    end
  end
end
