class ReportPolicy < ApplicationPolicy
  def ephemeris?
    user&.has_permission? :read
  end
end