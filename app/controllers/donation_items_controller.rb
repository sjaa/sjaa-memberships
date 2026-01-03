class DonationItemsController < ApplicationController
  before_action :set_donation_item, only: %i[ show edit update destroy ]

  # GET /donation_items or /donation_items.json
  def index
    @donation_items = DonationItem.all
  end

  # GET /donation_items/1 or /donation_items/1.json
  def show
  end

  # GET /donation_items/new
  def new
    @donation_item = DonationItem.new
  end

  # GET /donation_items/1/edit
  def edit
  end

  # POST /donation_items or /donation_items.json
  def create
    @donation_item = DonationItem.new(donation_item_params)

    respond_to do |format|
      if @donation_item.save
        format.html { redirect_to @donation_item, notice: "Donation item was successfully created." }
        format.json { render :show, status: :created, location: @donation_item }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @donation_item.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /donation_items/1 or /donation_items/1.json
  def update
    respond_to do |format|
      if @donation_item.update(donation_item_params)
        format.html { redirect_to @donation_item, notice: "Donation item was successfully updated." }
        format.json { render :show, status: :ok, location: @donation_item }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @donation_item.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /donation_items/1 or /donation_items/1.json
  def destroy
    @donation_item.destroy!

    respond_to do |format|
      format.html { redirect_to donation_items_path, status: :see_other, notice: "Donation item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_item
      @donation_item = DonationItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def donation_item_params
      params.require(:donation_item).permit(:value)
    end
end
