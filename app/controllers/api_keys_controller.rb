# Based on API Key article: https://keygen.sh/blog/how-to-implement-api-key-authentication-in-rails-without-devise/
class ApiKeysController < ApplicationController
  skip_forgery_protection

  include ApiKeyAuthenticatable 
 
  # Require token authentication for index                             
  prepend_before_action :authenticate_with_api_key!, only: [:index] 
 
  # Optional token authentication for logout                           
  prepend_before_action :authenticate_with_api_key, only: [:destroy] 

  def index
    # Only have admin bearers for now, but they all have api_keys
    render json: current_bearer.api_keys
  end
 
  def create
    # Authorization: Basic person@something.com:password
    authenticate_with_http_basic do |email, password| 
      admin = Admin.find_by email: email 
 
      if admin&.authenticate(password) 
        # Authorized, create key
        api_key = admin.api_keys.create! token: SecureRandom.hex 
 
        render json: api_key, status: :created
        return 
      end
    end

    # Unauthorized
    render :status => :unauthorized
  end
 
  def destroy
    current_api_key&.destroy
  end
end