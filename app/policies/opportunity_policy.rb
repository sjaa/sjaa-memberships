class OpportunityPolicy < ApplicationPolicy
  # Anyone can view opportunities (including non-authenticated users)
  def index?
    true
  end

  def show?
    true
  end

  # Anyone can contact about an opportunity
  def contact?
    true
  end

  # Only admins with write permission can create/edit/delete
  def new?
    user&.has_permission?(:write)
  end

  def create?
    user&.has_permission?(:write)
  end

  def edit?
    user&.has_permission?(:write)
  end

  def update?
    user&.has_permission?(:write)
  end

  def destroy?
    user&.has_permission?(:write)
  end
end
