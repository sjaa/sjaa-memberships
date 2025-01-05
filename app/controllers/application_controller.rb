class ApplicationController < ActionController::Base
  include Authenticatable
  prepend_before_action :authenticate!
  append_before_action :set_user

  private

  def set_user
    @user = current_user
  end
end
