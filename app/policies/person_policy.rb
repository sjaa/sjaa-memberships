class PersonPolicy < ApplicationPolicy
  def search?
    user&.has_permission? :read
  end

  # Members of SJAA can update their own information, but not do anything else.
  def update?
    user&.has_permission?(:write) || user.id == record.id
  end

  def edit?
    user&.has_permission?(:write) || user.id == record.id
  end

  def show?
    puts("[I] user: #{user.inspect}, record: #{record.inspect}")
    user&.has_permission?(:read) || user.id == record.id
  end
end