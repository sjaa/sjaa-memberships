require 'google/api_client/client_secrets'

class SessionsController < ApplicationController
  include Rails.application.routes.url_helpers

  skip_before_action :authenticate!, only: [:login, :create, :new_member, :signup, :signup_request, :signup_response]
  GOOGLE_SCOPES = [
    'https://www.googleapis.com/auth/spreadsheets', 
    'https://www.googleapis.com/auth/admin.directory.group',
    'https://www.googleapis.com/auth/admin.directory.group.member',
    'https://www.googleapis.com/auth/admin.directory.user.security',
    'https://www.googleapis.com/auth/admin.directory.user',
    'https://www.googleapis.com/auth/apps.groups.settings',
    'https://www.googleapis.com/auth/calendar.readonly',
  ]
  GOOGLE_CLIENT_SECRETS = Google::APIClient::ClientSecrets.new(JSON.parse Base64.decode64(ENV['GOOGLE_WEB_CLIENT_BASE64']))

  def public_login
  end

  def member_lookup
    @person = Person.find_by_email(params[:email])
    @email = params[:email]
  end

  def new_member
    @person = Person.create(contact_attributes: [{primary: true, email: params[:email]}], password: params[:password])
    if(@person.errors.any?)
      flash[:alert] = "Could not create account: #{@person.errors.full_messages.join(' ')}"
      redirect_to public_login_path
    else
      flash[:success] = "Created account for #{params[:email]}"
      session[:person_id] = @person.id
      redirect_to edit_person_path(@person)
    end
  end
  
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

  # Renders the sign-up form
  def signup
  end

  # Handle the sign up request
  def signup_request
    # Check for duplicates
    user = Admin.find_by(email: params[:email]) || Person.find_by_email(params[:email])

    if(user)
      redirect_to login_path, alert: "The email address #{params[:email]} is already registered.  Please log in or reset your password to continue."
      return
    end

    # Make sure all fields are filled out
    unless(params[:email].present? && params[:first_name].present? && params[:last_name].present?  && params[:password].present?)
      redirect_to signup_path, alert: "Please fill in *all* fields."
      return
    end

    # Generate encrypted token
    token = SignupToken.encode(
      first_name: login_params[:first_name],
      last_name: login_params[:last_name],
      email: login_params[:email],
      password: login_params[:password],
      expires_at: DateTime.now + 24.hours
    )

    # Email it out to the person
    AccountMailer.new_person(login_params[:email], token).deliver_now
    redirect_to login_path, notice: "Please check your email to complete signup"
  end

  # Handle the sign up response
  def signup_response
    # Verify and decode
    data = SignupToken.decode(params[:token])

    if(data.nil?)
      redirect_to login_path, alert: "Confirmation token was corrupted.  Please try signing up again."
      return
    end

    logger.debug "Decrypted data: #{data.inspect}"
    if(DateTime.now > data['expires_at'])
      redirect_to login_path, alert: "Confirmation token has expired.  Please try signing up again, and confirm your email within 24 hours."
      return
    end

    # Create account
    person = Person.create(first_name: data['first_name'], last_name: data['last_name'], password: data['password'])
    person.contacts << Contact.create(email: data['email'])

    # Create session (log in)
    session[:person_id] = person.id
    redirect_to membership_renewal_path(id: person.id), notice: 'Your password has been set and email confirmed!  Please complete the payment process below to activate your membership.'
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
      if(person.is_active?)
        redirect_to edit_person_path(person)
      else
        flash[:success] += '  Our records show that it is time to renew your membership.  If you would like to do that now, please use the form below to complete payment.'
        redirect_to membership_renewal_path(person)
      end
    else
      # If authentication fails, redirect to login with an error
      flash[:alert] = 'Login failed.'
      redirect_to :login
    end
  end

  def destroy
    session.delete(:admin_id)
    session.delete(:person_id)
    redirect_to :login, notice: 'Logged out.'
  end

  private

  def login_params
    params.permit(:email, :password, :first_name, :last_name)
  end

end
