# Based on API Key article: https://keygen.sh/blog/how-to-implement-api-key-authentication-in-rails-without-devise/
class ApiKeysController < ApplicationController
  skip_forgery_protection

  include Authenticatable 
 
  # Require token authentication for index                             
  skip_before_action :authenticate!, only: [:create] 
 
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