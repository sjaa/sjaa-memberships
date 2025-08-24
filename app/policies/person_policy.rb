class PersonPolicy < ApplicationPolicy
  def search?
    user&.has_permission? :read
  end

  def remind?
    user&.has_permission? :write
  end

  # Members of SJAA can update their own information, but not do anything else.
  def update?
    user&.has_permission?(:write) || user.id == record.id
  end

  def edit?
    user&.has_permission?(:write) || user.id == record.id
  end

  def new_membership?
    user&.has_permission?(:write) || user.id == record.id
  end

  def create_membership?
    user&.has_permission?(:write) || user.id == record.id
  end

  def show?
    user&.has_permission?(:read) || user.id == record.id
  end
end