class ReportPolicy < ApplicationPolicy
  def ephemeris?
    user&.has_permission? :read
  end

  def renewal_reminders?
    user&.has_permission? :read
  end

  def memberships?
    user&.has_permission? :read
  end
end