class PasswordResetsController < ApplicationController
  skip_before_action :authenticate!

  def new
  end

  def create
    user = Admin.find_by(email: params[:email]) || Person.find_by_email(params[:email])
    if user
      user.generate_password_reset_token!
      AccountMailer.password_reset(user).deliver_now
      redirect_to root_path, notice: 'Password reset email has been sent.'
    else
      flash.now[:alert] = 'Email address not found.'
      render :new
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
      redirect_to root_path, notice: 'Your password has been reset!'
    else
      render :edit
    end
  end

  private

  def find_by_reset_token
    Admin.find_by(reset_password_token: params[:id]) || Person.find_by(reset_password_token: params[:id])
  end

  def user_params
    params.permit(:password)
  end
end
