class PersonPolicy < ApplicationPolicy
  def search?
    user&.has_permission? :read
  end
end