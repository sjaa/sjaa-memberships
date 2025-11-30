class MentorshipController < ApplicationController
  include Sanitizable
  skip_before_action :policy_handling

  # GET /mentorship
  def index
    mentorship_filter
    respond_to do |format|
      format.html
    end
  end

  # POST /mentorship/search
  def search
    mentorship_filter
    render turbo_stream: turbo_stream.replace('mentors', partial: 'index')
  end

  # POST /mentorship/contact/:id
  def contact
    @mentor = Person.find(params[:id])
    @requester = current_user
    @message = params[:message]

    if @mentor && @message.present?
      begin
        AccountMailer.mentor_contact(@mentor, @requester, @message).deliver_now

        # Send real-time notification to mentor
        requester_name = @requester.respond_to?(:full_name) ? @requester.full_name : @requester.email
        NotificationBroadcaster.mentor_contact_received(@mentor, requester_name, @message)

        flash[:notice] = "Your message has been sent to #{@mentor.first_name} #{@mentor.last_name}."
        render json: { success: true, message: flash[:notice] }, status: :ok
      rescue => e
        logger.error "[MENTOR_CONTACT] Error sending email: #{e.message}"
        render json: { success: false, error: "Failed to send message. Please try again." }, status: :unprocessable_entity
      end
    else
      render json: { success: false, error: "Please provide a message." }, status: :unprocessable_entity
    end
  end

  private

  def mentorship_filter
    query_params = params.dup
    query_params.delete(:authenticity_token)
    query_params.delete(:submit)
    query_params.select! { |k, v| v.present? }
    query_params = query_params.permit(:skill_operation, skills: [])

    # Store for view access
    @query_params = query_params.to_h.with_indifferent_access

    qp = sanitize query_params.to_h
    logger.debug "[MENTORSHIP_FILTER] Params: #{qp.to_h.inspect}"

    # Start with all mentors
    query = Person.where(mentor: true)

    # Filter by skills if provided
    # Use AND logic: mentors must have ALL selected skills
    if qp[:skills].present?
      skill_ids = qp[:skills].reject(&:blank?).map(&:to_i).reject(&:zero?)

      if skill_ids.any?
        # For each skill, join and filter to ensure mentor has that skill
        skill_ids.each do |skill_id|
          query = query.where(
            id: Person.joins(:people_skills)
              .where(people_skills: { skill_id: skill_id })
              .select(:id)
          )
        end
      end
    end

    # Include all necessary associations for display
    @mentors = query.includes(
      :profile_picture_attachment,
      :interests,
      :skills,
      people_skills: :skill
    ).order(:last_name, :first_name)
  end
end
