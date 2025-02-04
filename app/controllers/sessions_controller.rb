class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:login, :create]
  GOOGLE_SCOPES = [
    'https://www.googleapis.com/auth/spreadsheets', 
    'https://www.googleapis.com/auth/admin.directory.group',
    'https://www.googleapis.com/auth/admin.directory.group.member',
    'https://www.googleapis.com/auth/admin.directory.user.security',
    'https://www.googleapis.com/auth/admin.directory.user',
  ]
  GOOGLE_OAUTH_CLIENT_ID="1078047122367-41rhdub3tj81hmsb6pbopqa5orus6msm.apps.googleusercontent.com"

  # Empty controller just renders the login form
  def login
  end

  def request_google_authorization
    @authUrl = 'https://accounts.google.com/o/oauth2/auth' +
    "?client_id=#{GOOGLE_OAUTH_CLIENT_ID}" +
    "&redirect_uri=#{google_callback_url}" +
    "&scope=#{GOOGLE_SCOPES.join(' ')}" + 
    '&response_type=code' +
    '&access_type=offline';
  end

  def google_oauth2_callback
    @code = params[:code]
    @scope = params[:scope]
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
