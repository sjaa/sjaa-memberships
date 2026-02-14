class StaticPagePolicy < ApplicationPolicy
  def unauthorized?
    true
  end

  def document_archive?
    true
  end
end