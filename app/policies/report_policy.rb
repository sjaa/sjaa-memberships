class ReportPolicy < ApplicationPolicy
  def ephemeris?
    user&.has_permission? :read
  end

  def renewal_reminders?
    user&.has_permission? :read
  end

  def create_google_group?
    user&.has_permission? :write
  end

  def memberships?
    user&.has_permission? :read
  end
end