class GooglePolicy < ApplicationPolicy
  def members?
    user&.has_permission? :write
  end

  def groups?
    user&.has_permission? :write
  end

  def group_sync?
    user&.has_permission? :write
  end

  def members_diff?
    user&.has_permission? :write
  end
end
