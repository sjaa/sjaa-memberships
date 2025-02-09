require 'google/api_client/client_secrets'

class SessionsController < ApplicationController
  include Rails.application.routes.url_helpers

  skip_before_action :authenticate!, only: [:login, :create]
  GOOGLE_SCOPES = [
    'https://www.googleapis.com/auth/spreadsheets', 
    'https://www.googleapis.com/auth/admin.directory.group',
    'https://www.googleapis.com/auth/admin.directory.group.member',
    'https://www.googleapis.com/auth/admin.directory.user.security',
    'https://www.googleapis.com/auth/admin.directory.user',
  ]
  GOOGLE_CLIENT_SECRETS = Google::APIClient::ClientSecrets.new(JSON.parse Base64.decode64(ENV['GOOGLE_WEB_CLIENT_BASE64']))

  # Empty controller just renders the login form
  def login
  end

  def request_google_authorization
    @authUrl = 'https://accounts.google.com/o/oauth2/auth' +
    "?client_id=#{GOOGLE_CLIENT_SECRETS.client_id}" +
    "&redirect_uri=#{google_callback_url}" +
    "&scope=#{GOOGLE_SCOPES.join(' ')}" + 
    '&response_type=code' +
    '&prompt=consent&' + 
    '&access_type=offline';
  end

  def google_oauth2_callback
    @code = params[:code]
    @scope = params[:scope]
    @auth = GOOGLE_CLIENT_SECRETS.to_authorization
    # Pick the redirect_uri that we generated earlier
    @auth.redirect_uri = google_callback_url
    @auth.code = @code
    @auth.fetch_access_token!

    # Save @auth.refresh_token for this user
    current_user.refresh_token = @auth.refresh_token
    if(current_user.save && @auth.refresh_token)
      flash[:success] = 'Successfully authorized with Google!'
    else
      flash[:alert] = 'Successfully authorized with Google!'
    end
  end

  # This is here for reference
  #  Next steps...
  #     Create some utilities, like members@sjaa.net management
  #     Redirect to the google_auth flow if no refresh token is found, or if it doesn't work
  def dummy_google_scratch
    require 'google/api_client/client_secrets'
    # By default looks for a 'client_secrets.json' file, or can accept a path
    client_secrets = Google::APIClient::ClientSecrets.load 
    # Alternatively
    cshash = JSON.parse Base64.decode64(ENV['GOOGLE_WEB_CLIENT_BASE64'])
    client_secrets = Google::APIClient::ClientSecrets.new cshash

    # Get the auth object
    auth = client_secrets.to_authorization
    # Set the code and fetch tokens
    auth.code = code # From oauth callback
    auth.fetch_access_token!
    # OR set the tokens if you have them stored already
    auth.refresh_token = refresh_token

    # Get a client from googleapis
    client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client.authorization = auth
    ret = client.list_members('members@sjaa.net')
    # list_members, insert_member, delete_member, etc
  end

  def forgot_password
  end

  def member_login
  end

  # Form handling from login
  def create
    # Lookup admin by email
    admin = Admin.find_by email: login_params[:email]
    person = Person.find_by_email login_params[:email]

    # Try to authenticate
    if(admin&.authenticate(login_params[:password]))
      # If authentication succeeds, then record session id and redirect to root with success
      session[:admin_id] = admin.id
      flash[:success] = 'Successful login!'
      redirect_to root_path
    elsif(person&.authenticate(login_params[:password]))
      session[:person_id] = person.id
      flash[:success] = 'Successful login!'
      redirect_to person_path(person)
    else
      # If authentication fails, redirect to login with an error
      flash[:alert] = 'Login failed.'
      redirect_to :login
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to :login, notice: 'Logged out.'
  end

  private

  def login_params
    params.permit(:email, :password)
  end

end
