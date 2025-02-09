class GooglePolicy < ApplicationPolicy
  def members?
    user&.has_permission? :read
  end

  def members_diff?
    user&.has_permission? :read
  end
end
