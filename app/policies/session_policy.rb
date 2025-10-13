class SessionPolicy < ApplicationPolicy
  def login?
    true
  end

  def signup_request?
    true
  end

  def signup_response?
    true
  end

  def new_member?
    true
  end

  def request_google_authorization?
    user&.is_a?(Admin)
  end

  def google_oauth2_callback?
    user&.is_a?(Admin)
  end

  def member_login?
    true
  end

  def destroy?
    true
  end

  def create?
    true
  end
end