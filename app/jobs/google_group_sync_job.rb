class GoogleGroupSyncJob < ApplicationJob
  queue_as :default
  include JobsHelper
  include GoogleHelper

  # Enable notifications for this job
  self.enable_notifications = true

  # GoogleGroupSyncJob.perform_later(
  #   admin_email,
  #   group_email,
  #   group_id: nil,
  #   members_only: true,
  #   use_remove_group: true,
  #   remove_group: GoogleHelper::REMOVE_GROUP,
  #   clear_remove_group: true,
  #   add_only: false,
  #   preview_only: false
  # )
  #
  # Syncs a Google Group with the membership database
  #   admin_email - Email of admin account with Google Groups access (e.g. vp@sjaa.net)
  #   group_email - Email of the Google Group to sync
  #   group_id - Optional ID of Group model to sync (uses active members if nil)
  #   members_only - If true, filter to only active members
  #   use_remove_group - If true, save removed members to a remove group
  #   remove_group - Email of the group to save removed members to
  #   clear_remove_group - If true, clear the remove group before adding removed members
  #   add_only - If true, only add members, don't remove
  #   preview_only - If true, only populate the remove group without modifying the primary group
  def perform(admin_email, group_email, group_id: nil, members_only: true, use_remove_group: true, remove_group: nil, clear_remove_group: true, add_only: false, preview_only: false)
    Rails.logger.info "[GoogleGroupSyncJob] Starting sync for #{group_email}"
    Rails.logger.info "[GoogleGroupSyncJob] Parameters: group_id=#{group_id}, members_only=#{members_only}, use_remove_group=#{use_remove_group}, remove_group=#{remove_group}, clear_remove_group=#{clear_remove_group}, add_only=#{add_only}, preview_only=#{preview_only}"

    # Find the admin
    admin = Admin.find_by(email: admin_email)
    unless admin&.refresh_token.present?
      Rails.logger.error "[GoogleGroupSyncJob] Admin #{admin_email} not found or has no refresh token"
      return
    end

    # Get the group model if specified
    group_model = nil
    if group_id.present? && group_id != 'members'
      group_model = Group.find_by(id: group_id)
      unless group_model
        Rails.logger.error "[GoogleGroupSyncJob] Group with ID #{group_id} not found"
        return
      end
    end

    # Get Google API authorization
    auth = get_auth(admin)

    # Use default remove_group if not specified
    remove_group ||= self.remove_group

    begin
      # Perform the sync
      diff_results = sync(
        auth: auth,
        group: group_email,
        group_model: group_model,
        members_only: members_only,
        use_remove_group: use_remove_group,
        remove_group: remove_group,
        clear_remove_group: clear_remove_group,
        add_only: add_only,
        admin_email: admin_email,
        preview_only: preview_only
      )

      # Log results
      to_add = diff_results[:unmatched_people].select { |person| person.email.present? }.size
      to_remove = diff_results[:group_unmatched].select { |mh| mh[:email] }.size
      errors = diff_results[:errors]&.size || 0

      if preview_only
        Rails.logger.info "[GoogleGroupSyncJob] Preview mode complete for #{group_email}"
        Rails.logger.info "[GoogleGroupSyncJob] #{to_remove} people added to remove group #{remove_group} (primary group not modified)"
      else
        Rails.logger.info "[GoogleGroupSyncJob] Sync complete for #{group_email}"
        Rails.logger.info "[GoogleGroupSyncJob] Added #{to_add} people, removed #{to_remove} people"
      end

      if errors > 0
        Rails.logger.warn "[GoogleGroupSyncJob] #{errors} errors occurred during sync"
        Rails.logger.warn "[GoogleGroupSyncJob] Errors: #{diff_results[:errors].inspect}"
      end

    rescue Google::Apis::ClientError => e
      Rails.logger.error "[GoogleGroupSyncJob] Google API error for #{group_email}: #{e.message}"
      raise e
    rescue => e
      Rails.logger.error "[GoogleGroupSyncJob] Error syncing #{group_email}: #{e.class.name} - #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e
    end
  end
end
