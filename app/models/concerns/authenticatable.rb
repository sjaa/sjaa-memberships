module Authenticatable
  extend ActiveSupport::Concern
 
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
 
  attr_reader :current_api_key
  attr_reader :current_bearer
  attr_reader :current_user
 
  # Use this to raise an error and automatically respond with a 401 HTTP status
  # code when API key authentication fails
  def authenticate!
    @current_user = authenticate

    # Raise the error
    if(!@current_user)
      respond_to do |format|
        format.html {render 'static_pages/unauthorized', status: :unauthorized}
        format.json {render json: {errors: ['Unauthorized']},status: :unauthorized}
      end
    end

    return @current_user
  end
 
  # Use this for optional API key authentication
  def authenticate
    admin = Admin.find_by id: session[:admin_id]
    @current_bearer = authenticate_with_http_token &method(:authenticator)
    @current_user = admin || @current_bearer

    return @current_user
  end
 
  private
 
  attr_writer :current_api_key
  attr_writer :current_bearer
  attr_writer :current_user
 
  def authenticator(http_token, options)
    @current_api_key = ApiKey.find_by token: http_token
 
    return current_api_key&.bearer
  end
end