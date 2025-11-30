class Notification < ApplicationRecord
  # Associations
  belongs_to :person, optional: true
  belongs_to :admin, optional: true

  # Validations
  validates :message, presence: true
  validates :category, inclusion: { in: %w[job_status membership mentorship admin_alert system] }
  validates :priority, inclusion: { in: %w[low normal high urgent] }
  validate :has_recipient

  # Scopes
  scope :unread, -> { where(unread: true) }
  scope :read, -> { where(unread: false) }
  scope :for_person, ->(person) { where(person: person) }
  scope :for_admin, ->(admin) { where(admin: admin) }
  scope :for_user, ->(user) do
    if user.is_a?(Admin)
      where(admin: user)
    elsif user.is_a?(Person)
      where(person: user)
    else
      none
    end
  end
  scope :by_priority, -> { order(Arel.sql("CASE priority WHEN 'urgent' THEN 1 WHEN 'high' THEN 2 WHEN 'normal' THEN 3 WHEN 'low' THEN 4 END"), created_at: :desc) }
  scope :recent, -> { order(created_at: :desc) }
  scope :old, ->(days = 10) { where('created_at < ?', days.days.ago) }
  scope :by_category, ->(category) { where(category: category) }

  # Callbacks
  after_create_commit :broadcast_notification

  # Class methods
  def self.cleanup_old_notifications(days = 10)
    old(days).destroy_all
  end

  # Instance methods
  def recipient
    person || admin
  end

  def mark_as_read!
    update(unread: false)
  end

  def mark_as_unread!
    update(unread: true)
  end

  private

  def has_recipient
    if person_id.blank? && admin_id.blank?
      errors.add(:base, "Notification must have either a person or admin recipient")
    elsif person_id.present? && admin_id.present?
      errors.add(:base, "Notification cannot have both person and admin recipients")
    end
  end

  def broadcast_notification
    return unless recipient

    NotificationChannel.broadcast_to(
      recipient,
      {
        id: id,
        message: message,
        category: category,
        priority: priority,
        action_url: action_url,
        created_at: created_at.iso8601,
        unread: unread
      }
    )
  end
end
