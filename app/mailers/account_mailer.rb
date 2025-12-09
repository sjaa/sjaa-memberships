class AccountMailer < ApplicationMailer
  default from: 'website@sjaa.net', reply_to: 'asksjaa@sjaa.net'
  helper :application, :markdown

  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail(to: @user.email, subject: '[SJAA] Password Reset Instructions')
  end

  def new_person(email, token)
    @url = signup_response_url(token)
    mail(to: email, subject: '[SJAA] Please Confirm Your Email Address')
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
    order_donation = @order&.membership_params&.dig('donation_amount')
    @order_total = @order&.price || membership&.total.to_f
    @order_donation = order_donation ? order_donation.to_f : membership&.donation_amount.to_f
    @person = membership.person
    @renewal = @person.memberships.count > 1
    mail(to: @person.email, bcc: %w(officers@sjaa.net memberships@sjaa.net donations@sjaa.net), subject: "SJAA Membership - Welcome and Thank You! (#{@person&.last_name}, #{@person&.first_name})")
  end

  def donation_letter(donation, custom_message: nil, cc_emails: nil)
    @donor = donation&.person
    @donation = donation
    @custom_message = custom_message
    return nil if(@donor.nil? || donation.nil? || @donor.email.nil?)

    # Attach logo as inline image
    attachments.inline['logo_small.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'logo_small.png'))

    mail_options = {
      to: @donor.email,
      reply_to: 'donations@sjaa.net',
      bcc: %w(officers@sjaa.net memberships@sjaa.net donations@sjaa.net),
      subject: "SJAA Donation (#{@donor&.last_name}, #{@donor&.first_name})"
    }

    # Add CC emails if provided
    mail_options[:cc] = cc_emails if cc_emails.present?

    mail(mail_options)
  end

  def mentor_contact(mentor, requester, message)
    @mentor = mentor
    @requester = requester
    @message = message
    return nil if @mentor.nil? || @mentor.email.nil? || @message.blank?

    reply_to_email = @requester&.email || 'asksjaa@sjaa.net'
    @requester_name = @requester&.class == Person ? "#{@requester.first_name} #{@requester.last_name}" : @requester&.email

    mail(
      to: @mentor.email,
      reply_to: reply_to_email,
      subject: "[SJAA Mentorship] Message from #{@requester_name}"
    )
  end

  def opportunity_contact(opportunity, requester, message)
    @opportunity = opportunity
    @requester = requester
    @message = message
    return nil if @opportunity.nil? || @message.blank?

    reply_to_email = @requester&.email || 'asksjaa@sjaa.net'
    @requester_name = @requester&.class == Person ? "#{@requester.first_name} #{@requester.last_name}" : @requester&.email

    # Build recipients list: opportunity contact, volunteer@sjaa.net, and requester
    recipients = []
    recipients << @opportunity.email if @opportunity.email.present?
    recipients << 'volunteer@sjaa.net'
    recipients << @requester.email if @requester&.email.present?
    recipients = recipients.uniq.compact

    mail(
      to: recipients,
      reply_to: reply_to_email,
      subject: "[SJAA Volunteer] Interest in: #{@opportunity.title}"
    )
  end

  def volunteer_opportunity_matches(person, full_matches, partial_matches, no_skill_required)
    @person = person
    @full_matches = full_matches
    @partial_matches = partial_matches
    @no_skill_required = no_skill_required
    @opportunities_url = opportunities_url

    return nil if @person.nil? || @person.email.nil?

    mail(
      to: @person.email,
      subject: '[SJAA] Volunteer Opportunities Match Your Skills'
    )
  end
end
