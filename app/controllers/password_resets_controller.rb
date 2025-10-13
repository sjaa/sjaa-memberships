class PasswordResetsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @email = params[:email]
  end

  def create
    user = Admin.find_by(email: params[:email]) || Person.find_by_email(params[:email])

    if user
      user.generate_password_reset_token!
      AccountMailer.password_reset(user).deliver_now
      redirect_to login_path, notice: 'Password reset email has been sent.'
    else
      flash[:alert] = 'Email address not found.  Please sign up or correct your address.'
      redirect_to login_path
    end
  end

  def edit
    @user = find_by_reset_token
    if @user.nil? || !@user.password_reset_token_valid?
      redirect_to new_password_reset_path, alert: 'Password reset token is invalid or expired.'
    end
  end

  def update
    @user = find_by_reset_token

    if @user.update(user_params)
      @user.reset_password!(params[:password])
      key = @user.is_a?(Admin) ? :admin_id : :person_id
      session[key] = @user.id
      redirect_to @user.is_a?(Admin) ? root_path : edit_person_path(id: @user.id), notice: 'Your password has been reset!'
    else
      flash[:error] = "Password could not be saved.  Please try again."
      redirect_to login_path
    end
  end

  private

  def find_by_reset_token
    Admin.find_by(reset_password_token: params[:id]) || Person.find_by(reset_password_token: params[:id])
  end

  def user_params
    params.permit(:password)
  end

  def person_params
    params.permit(:first_name, :last_name)
  end

  def contact_params
    params.permit(:email)
  end
end
