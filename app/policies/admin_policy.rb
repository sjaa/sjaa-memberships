class AdminPolicy < ApplicationPolicy
  def index?
    user&.has_permission? :permit
  end

  def show?
    user&.has_permission? :permit
  end

  def create?
    user&.has_permission? :permit
  end

  def new?
    user&.has_permission? :permit
  end

  def update?
    user&.has_permission? :permit
  end

  def edit?
    user&.has_permission? :permit
  end

  def destroy?
    user&.has_permission? :permit
  end

end