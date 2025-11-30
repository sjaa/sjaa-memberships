class NotificationBroadcaster
  class << self
    # Notify about background job events
    def job_queued(job, recipient, message: nil)
      create_notification(
        recipient: recipient,
        message: message || "Job '#{job.class.name}' has been queued",
        category: 'job_status',
        priority: 'low',
        job_id: job.job_id,
        job_status: 'queued'
      )
    end

    def job_started(job, recipient, message: nil)
      update_or_create_job_notification(
        job_id: job.job_id,
        recipient: recipient,
        message: message || "Job '#{job.class.name}' is now running",
        job_status: 'running',
        priority: 'low'
      )
    end

    def job_completed(job, recipient, message: nil, action_url: nil)
      update_or_create_job_notification(
        job_id: job.job_id,
        recipient: recipient,
        message: message || "Job '#{job.class.name}' completed successfully",
        job_status: 'completed',
        priority: 'normal',
        action_url: action_url
      )
    end

    def job_failed(job, recipient, exception, message: nil)
      update_or_create_job_notification(
        job_id: job.job_id,
        recipient: recipient,
        message: message || "Job '#{job.class.name}' failed: #{exception.message}",
        job_status: 'failed',
        priority: 'high'
      )
    end

    # Notify about membership events
    def membership_renewal_reminder(person, days_until_expiration)
      create_notification(
        recipient: person,
        message: "Your membership expires in #{days_until_expiration} days. Please renew to continue enjoying member benefits.",
        category: 'membership',
        priority: days_until_expiration <= 7 ? 'high' : 'normal',
        action_url: "/memberships/renewal/#{person.id}"
      )
    end

    def membership_expired(person)
      create_notification(
        recipient: person,
        message: "Your membership has expired. Renew now to regain access.",
        category: 'membership',
        priority: 'urgent',
        action_url: "/memberships/renewal/#{person.id}"
      )
    end

    def membership_activated(person, membership)
      create_notification(
        recipient: person,
        message: "Welcome! Your membership has been activated and is valid until #{(membership.start + membership.term_months.months).strftime('%B %d, %Y')}.",
        category: 'membership',
        priority: 'normal',
        action_url: "/people/#{person.id}"
      )
    end

    def payment_received(person, amount)
      create_notification(
        recipient: person,
        message: "Payment of $#{amount} received. Thank you!",
        category: 'membership',
        priority: 'normal'
      )
    end

    # Notify about mentorship events
    def mentor_contact_received(mentor, requester_name, message_preview)
      create_notification(
        recipient: mentor,
        message: "#{requester_name} sent you a mentorship request: '#{message_preview.truncate(50)}'",
        category: 'mentorship',
        priority: 'normal',
        action_url: "/mentorship"
      )
    end

    # Admin notifications
    def new_member_signup(admin, person)
      create_notification(
        recipient: admin,
        message: "New member signed up: #{person.full_name} (#{person.primary_email})",
        category: 'admin_alert',
        priority: 'normal',
        action_url: "/people/#{person.id}"
      )
    end

    def google_sync_error(admin, error_message)
      create_notification(
        recipient: admin,
        message: "Google sync error: #{error_message}",
        category: 'admin_alert',
        priority: 'high'
      )
    end

    def csv_import_completed(admin, imported_count, errors_count = 0)
      message = "CSV import completed: #{imported_count} records imported"
      message += ", #{errors_count} errors" if errors_count > 0

      create_notification(
        recipient: admin,
        message: message,
        category: 'admin_alert',
        priority: errors_count > 0 ? 'high' : 'normal'
      )
    end

    # System notifications
    def system_message(recipient, message, priority: 'normal', action_url: nil)
      create_notification(
        recipient: recipient,
        message: message,
        category: 'system',
        priority: priority,
        action_url: action_url
      )
    end

    private

    def create_notification(recipient:, message:, category:, priority:, job_id: nil, job_status: nil, action_url: nil)
      attrs = {
        message: message,
        category: category,
        priority: priority,
        job_id: job_id,
        job_status: job_status,
        action_url: action_url
      }

      if recipient.is_a?(Admin)
        attrs[:admin_id] = recipient.id
      elsif recipient.is_a?(Person)
        attrs[:person_id] = recipient.id
      else
        Rails.logger.error "Invalid recipient type: #{recipient.class.name}"
        return nil
      end

      Notification.create!(attrs)
    rescue StandardError => e
      Rails.logger.error "Failed to create notification: #{e.message}"
      nil
    end

    def update_or_create_job_notification(job_id:, recipient:, message:, job_status:, priority:, action_url: nil)
      # Try to find existing notification for this job
      notification = Notification.find_by(job_id: job_id)

      if notification
        # Update existing notification
        notification.update(
          message: message,
          job_status: job_status,
          priority: priority,
          action_url: action_url,
          unread: true,  # Mark as unread again for status updates
          updated_at: Time.current
        )

        # Re-broadcast the updated notification
        notification.send(:broadcast_notification)
        notification
      else
        # Create new notification
        create_notification(
          recipient: recipient,
          message: message,
          category: 'job_status',
          priority: priority,
          job_id: job_id,
          job_status: job_status,
          action_url: action_url
        )
      end
    end
  end
end
