class AccountMailer < ApplicationMailer
  default from: 'website@sjaa.net', reply_to: 'allpersonnel@sjaa.net'

  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail(to: @user.email, subject: '[SJAA] Password Reset Instructions')
  end

  def new_person(person)
    @person = person
    @url = edit_password_reset_url(person.reset_password_token, signup: true)
    mail(to: @person.email, subject: '[SJAA] Please Confirm Your Email Address')
  end
end
