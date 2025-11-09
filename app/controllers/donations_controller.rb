class DonationsController < ApplicationController
  before_action :set_donation, only: %i[ show edit update destroy send_letter ]
  include Resizable
  
  INCLUDES = [:person, items: [:phases, equipment: :instrument]]
  
  # GET /donations or /donations.json
  def index
    filter
    render partial: 'index' if(params[:page])
  end
  
  def search
    filter
    render turbo_stream: turbo_stream.replace('donations', partial: 'index')
  end
  
  # GET /donations/1 or /donations/1.json
  def show
  end
  
  # GET /donations/new
  def new
    @donation = Donation.new
    item = DonationItem.new
    item.phases << DonationPhase.new
    @donation.items << item
  end
  
  # GET /donations/1/edit
  def edit
  end
  
  # POST /donations or /donations.json
  def create
    @donation = Donation.new(donation_params)
    
    respond_to do |format|
      if @donation.save
        attach_equipment_images
        format.html { redirect_to @donation, notice: "Donation was successfully created." }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /donations/1 or /donations/1.json
  def update
    respond_to do |format|
      # If items_attributes is missing from params, explicitly set it to empty array
      # to trigger removal of all equipment items while preserving cash items
      params_to_update = donation_params
      params_to_update[:items_attributes] ||= []

      if @donation.update(params_to_update)
        attach_equipment_images
        format.html { redirect_to @donation, notice: "Donation was successfully updated." }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /donations/1 or /donations/1.json
  def destroy
    @donation.destroy!
    
    respond_to do |format|
      format.html { redirect_to donations_path, status: :see_other, notice: "Donation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def send_letter
    AccountMailer.donation_letter(@donation).deliver_now
    redirect_to @donation, notice: 'Donation Letter was sent.'
  end
  
  private
  
  def filter
    @query_params = params.dup
    @query_params.delete(:authenticity_token)
    @query_params.delete(:submit)
    @query_params.select!{|k,v| v.present?}
    Rails.logger.info "query_params: #{@query_params.inspect}"
    @query_params = @query_params.permit(:person_id, :from_date, :to_date, :from_value, :to_value)
    qp = @query_params

    query = Donation.all.select(:id)
    query = query.joins(items: [:phases]).where(phases: {person_id: qp[:person_id]}) if(qp[:person_id].present?)
    query = query.joins(:items).where(DonationItem.arel_table[:value].gteq(qp[:from_value])) if(qp[:from_value].present?)
    query = query.joins(:items).where(DonationItem.arel_table[:value].lteq(qp[:to_value])) if(qp[:to_value].present?)
    query = query.joins(items: [:phases]).where(DonationPhase.arel_table[:date].gteq(qp[:from_date])) if(qp[:from_date].present?)
    query = query.joins(items: [:phases]).where(DonationPhase.arel_table[:date].lteq(qp[:to_date])) if(qp[:to_date].present?)

    donations = Donation.where(id: query).includes(INCLUDES)
    Rails.logger.info "donations: #{query.map(&:id).inspect}"

    @pagy, @donations = pagy(donations, limit: 40, params: @query_params.to_h)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_donation
    @donation = Donation.includes(INCLUDES).find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def donation_params
    params.require(:donation).permit(
    :date, :value, :note, :person_id, :name,
    cash: [:id, :value, :cash],
    person_attributes: [:email, :first_name, :last_name],
    items_attributes: [:id, :value, phase_attributes: [:id, :name, :person_id, :date], equipment_attributes: [:id, :note, images: [], instrument_attributes: [:kind, :model]]]
    )
  end

  def attach_equipment_images
    @donation.items.each_with_index do |di, i|
      equipment = di.equipment
      next if(equipment.nil? || donation_params&.dig(:items_attributes)&.dig(i)&.dig(:equipment_attributes)&.dig(:images).nil?)
      resize_and_attach(images: donation_params[:items_attributes][i][:equipment_attributes][:images], object: equipment) unless(equipment.nil?)
    end
  end
end
