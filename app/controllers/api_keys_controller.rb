# Based on API Key article: https://keygen.sh/blog/how-to-implement-api-key-authentication-in-rails-without-devise/
class ApiKeysController < ApplicationController
  skip_forgery_protection
  
  include Authenticatable 
  
  # Require authentication for index
  skip_before_action :authenticate!, only: [:create] 
  
  def index
    @keys = current_user&.api_keys || []
    
    # Only have admin bearers for now, but they all have api_keys
    respond_to do |format|
      format.json { render json: @keys.map{|key| {token: key.token, permissions: key.bearer.permissions.map(&:name)}} }
      format.html
    end
  end
  
  def create
    respond_to do |format|
      format.html do
        authenticate!
        @api_key = current_user&.api_keys&.create! token: SecureRandom.hex 
        @keys = current_user&.api_keys || []
        if(@api_key&.errors&.any?)
          flash[:alert] = "Encountered errors: #{@api_key&.errors&.full_messages&.join(' ')}"
        else
          flash[:success] = "Generated token: #{@api_key&.token}"
        end
        redirect_to api_keys_path
      end

      format.json do 
        # Authorization: Basic person@something.com:password
        authenticate_with_http_basic do |email, password| 
          admin = Admin.find_by email: email 
          
          if admin&.authenticate(password) 
            # Authorized, create key
            api_key = admin.api_keys.create! token: SecureRandom.hex 
            
            render json: {token: api_key.token, permissions: admin.permissions.map(&:name)}, status: :created
            return 
          end
        end
        
        # Unauthorized
        render json: {errors: ['Unauthorized']}, :status => :unauthorized
      end
    end
  end
  
  def destroy
    respond_to do |format|
      format.html do
        @api_key = ApiKey.find(params[:id])
        @api_key&.destroy
        redirect_to api_keys_path
      end
      format.json {current_api_key&.destroy}
    end
  end
end