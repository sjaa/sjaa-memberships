class SessionPolicy < ApplicationPolicy
  def login?
    true
  end

  def destroy?
    true
  end

  def create?
    true
  end
end