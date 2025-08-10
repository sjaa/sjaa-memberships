class AccountMailer < ApplicationMailer
  default from: 'website@sjaa.net', reply_to: 'allpersonnel@sjaa.net'
  helper :application

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

  def sample()
    mail(to: 'vp@sjaa.net', subject: '[SJAA] Test Email')
  end

  def renewal_notice(person)
    @person = person
    @expiration_date = person&.latest_membership&.end
    @renew_url = membership_renewal_url(id: person.id)
    mail(to: @person.email, subject: '[SJAA] Time to Renew Your SJAA Membership')
  end

  def welcome(membership)
    @membership = membership
    @order = membership&.order
    @order_total = @order&.price || 0
    @order_donation = @order&.membership_params&.dig(:donation_amount).to_f
    @person = membership.person
    @renewal = @person.memberships.count > 1
    mail(to: @person.email, bcc: %w(officers@sjaa.net memberships@sjaa.net donations@sjaa.net), subject: "SJAA Membership - Welcome and Thank You! (#{@person&.last_name}, #{@person&.first_name})")
  end
end
