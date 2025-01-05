class ApplicationController < ActionController::Base
  include Authenticatable
  include Pundit::Authorization

  prepend_before_action :authenticate!
  append_before_action :set_user

  append_before_action :policy_handling
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_user
    @user = current_user
  end

  def policy_handling
    # Pick a policy, any policy
    policyClass = nil
    begin
      policyClass = "#{self.class.name.split('C')[0].singularize}Policy".constantize
    rescue
      policyClass = ApplicationPolicy
    end
    authorize self.class, policy_class: policyClass
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    respond_to do |format|
      format.html {redirect_back_or_to(root_path)}
      format.json {render json: {errors: ['Unauthorized by policy']}, status: :unauthorized}
    end
  end
end
