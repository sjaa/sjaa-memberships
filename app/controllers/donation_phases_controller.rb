class DonationPhasesController < ApplicationController
  before_action :set_donation_phase, only: %i[ show edit update destroy ]

  # GET /donation_phases or /donation_phases.json
  def index
    @donation_phases = DonationPhase.all
  end

  # GET /donation_phases/1 or /donation_phases/1.json
  def show
  end

  # GET /donation_phases/new
  def new
    @donation_phase = DonationPhase.new
  end

  # GET /donation_phases/1/edit
  def edit
  end

  # POST /donation_phases or /donation_phases.json
  def create
    @donation_phase = DonationPhase.new(donation_phase_params)

    respond_to do |format|
      if @donation_phase.save
        format.html { redirect_to @donation_phase, notice: "Donation phase was successfully created." }
        format.json { render :show, status: :created, location: @donation_phase }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @donation_phase.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /donation_phases/1 or /donation_phases/1.json
  def update
    respond_to do |format|
      if @donation_phase.update(donation_phase_params)
        format.html { redirect_to @donation_phase, notice: "Donation phase was successfully updated." }
        format.json { render :show, status: :ok, location: @donation_phase }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @donation_phase.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /donation_phases/1 or /donation_phases/1.json
  def destroy
    @donation_phase.destroy!

    respond_to do |format|
      format.html { redirect_to donation_phases_path, status: :see_other, notice: "Donation phase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_phase
      @donation_phase = DonationPhase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def donation_phase_params
      params.require(:donation_phase).permit(:name, :date)
    end
end
