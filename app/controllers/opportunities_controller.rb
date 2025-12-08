class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  # GET /opportunities
  # Public view for all users (including non-authenticated)
  def index
    @opportunities = Opportunity.includes(:opportunity_skills, :skills).all

    # If user is a Person, sort by skill match
    if @user&.is_a?(Person)
      @opportunities_with_match = Opportunity.for_person(@user)
    else
      @opportunities_with_match = @opportunities.map { |o| [o, 0, false] }
    end
  end

  # GET /opportunities/1
  def show
    @matching = @user&.is_a?(Person) ? @opportunity.matches_person?(@user) : false
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
    @skills = Skill.order(:name)
  end

  # GET /opportunities/1/edit
  def edit
    @skills = Skill.order(:name)
  end

  # POST /opportunities
  def create
    @opportunity = Opportunity.new(opportunity_params)

    if @opportunity.save
      redirect_to @opportunity, notice: 'Opportunity was successfully created.'
    else
      @skills = Skill.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /opportunities/1
  def update
    if @opportunity.update(opportunity_params)
      redirect_to @opportunity, notice: 'Opportunity was successfully updated.'
    else
      @skills = Skill.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /opportunities/1
  def destroy
    @opportunity.destroy
    redirect_to opportunities_url, notice: 'Opportunity was successfully deleted.'
  end

  # POST /opportunities/:id/contact
  def contact
    @opportunity = Opportunity.find(params[:id])
    @requester = @user
    @message = params[:message]

    if @opportunity && @message.present?
      begin
        AccountMailer.opportunity_contact(@opportunity, @requester, @message).deliver_now
        redirect_to @opportunity, notice: "Your message has been sent regarding '#{@opportunity.title}'."
      rescue => e
        logger.error "[OPPORTUNITY_CONTACT] Error sending email: #{e.message}"
        redirect_to @opportunity, alert: "Failed to send message. Please try again."
      end
    else
      redirect_to @opportunity, alert: "Please provide a message."
    end
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  def opportunity_params
    params.require(:opportunity).permit(:title, :description, :email, skills_attributes: [:skill_id, :skill_level])
  end
end
