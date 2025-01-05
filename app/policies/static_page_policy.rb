class StaticPagePolicy < ApplicationPolicy
  def unauthorized?
    true
  end
end