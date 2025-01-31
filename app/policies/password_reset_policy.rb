class PasswordResetPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def edit?
    true
  end
end
