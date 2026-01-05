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
    'https://www.googleapis.com/auth/calendar.events',
  ]
  # Load Google client secrets from AppConfig (lazy-loaded)
  def self.google_client_secrets
    @google_client_secrets ||= Google::APIClient::ClientSecrets.new(
      JSON.parse Base64.decode64(AppConfig.google_web_client_base64)
    )
  end

  GOOGLE_CLIENT_SECRETS = -> { SessionsController.google_client_secrets }

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
    "?client_id=#{GOOGLE_CLIENT_SECRETS.call.client_id}" +
    "&redirect_uri=#{google_callback_url}" +
    "&scope=#{GOOGLE_SCOPES.join(' ')}" +
    '&response_type=code' +
    '&prompt=consent&' +
    '&access_type=offline';
  end

  def google_oauth2_callback
    @code = params[:code]
    @scope = params[:scope]
    @auth = GOOGLE_CLIENT_SECRETS.call.to_authorization
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

    # Check for similar names (soft warning, not a blocker)
    # Skip check if user has already acknowledged the warning
    unless params[:acknowledge_warning] == 'true'
      # Create a temporary Person object to check for similar names
      temp_person = Person.new(first_name: params[:first_name], last_name: params[:last_name])
      similar_people = NameSimilarityDetector.find_similar(temp_person, threshold: 0.85, limit: 3)

      if similar_people.any?
        # Build warning message
        names = similar_people.map { |p, score| "#{p.name} (#{(score * 100).round}% match)" }.join(', ')
        flash[:warning] = "We found existing accounts with similar names: #{names}. If one of these is you, please try logging in with a different email or resetting your password instead. If this is not you, you may continue signing up."

        # Store signup data in session to repopulate the form
        session[:signup_data] = {
          'first_name' => params[:first_name],
          'last_name' => params[:last_name],
          'email' => params[:email],
          'acknowledge_warning' => 'true'
        }

        # Redirect back to signup form with the warning
        redirect_to signup_path
        return
      end
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
    redirect_to login_path, notice: "We sent you an email to complete the sign up process.  It may take a few minutes to arrive, but please check your email to complete signup."
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

    # Check if person already exists with this email
    existing_person = Person.find_by_email(data['email'])
    if existing_person
      redirect_to login_path, alert: "An account with the email #{data['email']} already exists. Please log in to continue."
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
      redirect_to_return_path(default: root_path)
    elsif(person&.authenticate(login_params[:password]))
      session[:person_id] = person.id
      flash[:success] = 'Successful login!'
      if(person.is_active?)
        redirect_to_return_path(default: person_path(person))
      else
        flash[:success] += '  Our records show that it is time to renew your membership.  If you would like to do that now, please use the form below to complete payment.'
        redirect_to_return_path(default: membership_renewal_path(person))
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
    params.permit(:email, :password, :first_name, :last_name, :authenticity_token, :commit)
  end

  def redirect_to_return_path(default:)
    return_to = session.delete(:return_to)
    # Only redirect to return_to if it's a safe, relative path (not an external URL)
    if return_to && return_to.start_with?('/')
      redirect_to return_to
    else
      redirect_to default
    end
  end

end
