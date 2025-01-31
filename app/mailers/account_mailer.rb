class AccountMailer < ApplicationMailer
  default from: 'website@sjaa.net', reply_to: 'allpersonnel@sjaa.net'

  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail(to: @user.email, subject: 'Password Reset Instructions')
  end
end
