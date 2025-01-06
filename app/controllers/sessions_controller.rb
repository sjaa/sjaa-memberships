class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:login, :create]

  # Empty controller just renders the login form
  def login
  end

  # Form handling from login
  def create
    # Lookup admin by email
    admin = Admin.find_by email: login_params[:email]

    # Try to authenticate
    if(admin&.authenticate(login_params[:password]))
      # If authentication succeeds, then record session id and redirect to root with success
      session[:admin_id] = admin.id
      flash[:success] = 'Successful login!'
      redirect_to root_path
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
