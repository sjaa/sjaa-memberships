# frozen_string_literal: true

class AppConfigPolicy < ApplicationPolicy
  def index?
    user&.has_permission? :permit
  end

  def edit?
    user&.has_permission? :permit
  end

  def update?
    user&.has_permission? :permit
  end

  def seed_from_env?
    user&.has_permission? :permit
  end
end
