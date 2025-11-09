# frozen_string_literal: true

class SkillPolicy < ApplicationPolicy
  # Anyone with read permission can view skills
  def show?
    user&.has_permission?(:read)
  end

  # Only admins with write permission can manage skills
  def index?
    user&.has_permission?(:read)
  end

  def create?
    user&.has_permission?(:write)
  end

  def new?
    user&.has_permission?(:write)
  end

  def update?
    user&.has_permission?(:write)
  end

  def edit?
    user&.has_permission?(:write)
  end

  def destroy?
    user&.has_permission?(:write)
  end
end
