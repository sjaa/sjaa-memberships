class ImportGroupCsvJob < ApplicationJob
  queue_as :default
  include GoogleHelper

  # ImportGroupCsvJob.perform_later(group_id, csv_content, admin_id)
  #   group_id - ID of the group to add members to
  #   csv_content - String content of the CSV file
  #   admin_id - ID of admin performing the import (for Google API access)
  #
  # Imports email addresses from a CSV and adds them to both the database group and Google Group
  def perform(group_id, csv_content, admin_id)
    group = Group.find_by(id: group_id)
    admin = Admin.find_by(id: admin_id)

    unless group
      Rails.logger.error "[ImportGroupCsvJob] Group with ID #{group_id} not found"
      return
    end

    unless admin&.refresh_token.present?
      Rails.logger.error "[ImportGroupCsvJob] Admin with ID #{admin_id} not found or has no Google credentials"
      return
    end

    # Get Google API authorization
    auth = get_auth(admin)
    unless auth
      Rails.logger.error "[ImportGroupCsvJob] Failed to get Google authorization for admin #{admin.id}"
      return
    end

    # Use the shared importer service
    begin
      importer = GroupCsvImporter.new(group: group, auth: auth, csv_content: csv_content)
      result = importer.import

      unless result[:success]
        Rails.logger.error "[ImportGroupCsvJob] Import failed: #{result[:error]}"
        return
      end

      # Log results
      results = result[:results]
      Rails.logger.info "[ImportGroupCsvJob] Completed for group #{group.id} (#{group.email}): " \
                        "#{results[:added].count} added, " \
                        "#{results[:skipped].count} skipped, " \
                        "#{results[:added_to_db].count} added to DB, " \
                        "#{results[:errors].count} errors"

      if results[:errors].any?
        results[:errors].each do |error|
          Rails.logger.error "[ImportGroupCsvJob] Error with #{error[:email]}: #{error[:error]}"
        end
      end

    rescue => e
      Rails.logger.error "[ImportGroupCsvJob] Error: #{e.class.name} - #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e
    end
  end
end
