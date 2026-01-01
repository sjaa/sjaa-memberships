class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  # Attribute to store the user who initiated the job
  attr_accessor :initiated_by

  # Allow jobs to opt-in to notifications
  class_attribute :enable_notifications, default: false

  # Lifecycle callbacks for notifications
  before_enqueue do |job|
    if job.class.enable_notifications && job.initiated_by
      NotificationBroadcaster.job_queued(job, job.initiated_by)
    end
  end

  before_perform do |job|
    if job.class.enable_notifications && job.initiated_by
      NotificationBroadcaster.job_started(job, job.initiated_by)
    end
  end

  after_perform do |job|
    if job.class.enable_notifications && job.initiated_by
      NotificationBroadcaster.job_completed(job, job.initiated_by)
    end
  end

  rescue_from StandardError do |exception|
    # Send notification to the user who initiated the job
    if self.class.enable_notifications && initiated_by
      NotificationBroadcaster.job_failed(self, initiated_by, exception)
    end

    # Explicitly notify Airbrake (in addition to automatic notification)
    # This ensures errors are tracked even if automatic tracking fails
    if defined?(Airbrake)
      Airbrake.notify(exception) do |notice|
        notice[:context][:job_class] = self.class.name
        notice[:context][:job_id] = job_id
        notice[:context][:arguments] = arguments
        notice[:context][:initiated_by] = initiated_by&.email if initiated_by.respond_to?(:email)
      end
    end

    raise exception
  end

  # Helper methods to set the initiator when performing jobs
  # user can be: Person, Admin, person email string, admin email string, person ID (integer), or admin ID (integer)
  def self.perform_later_with_notifications(user, *args)
    job = new(*args)
    job.initiated_by = resolve_user(user)
    job.enqueue
  end

  def self.perform_now_with_notifications(user, *args)
    job = new(*args)
    job.initiated_by = resolve_user(user)
    job.perform_now
  end

  private

  # Resolve various user identifier formats to actual Person or Admin objects
  def self.resolve_user(user)
    return user if user.is_a?(Person) || user.is_a?(Admin)

    if user.is_a?(String)
      # Try as email - check both Admin and Person
      Admin.find_by(email: user) || Person.find_by_email(user)
    elsif user.is_a?(Integer)
      # Try as ID - check Admin first, then Person
      Admin.find_by(id: user) || Person.find_by(id: user)
    else
      user
    end
  end
end
