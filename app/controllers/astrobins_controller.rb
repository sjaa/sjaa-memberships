class AstrobinsController < ApplicationController
  before_action :set_astrobin, only: %i[ show edit update destroy ]

  # GET /astrobins or /astrobins.json
  def index
    @astrobins = Astrobin.all
  end

  # GET /astrobins/1 or /astrobins/1.json
  def show
  end

  # GET /astrobins/new
  def new
    @astrobin = Astrobin.new
  end

  # GET /astrobins/1/edit
  def edit
  end

  # POST /astrobins or /astrobins.json
  def create
    @astrobin = Astrobin.new(astrobin_params)

    respond_to do |format|
      if @astrobin.save
        format.html { redirect_to @astrobin, notice: "Astrobin was successfully created." }
        format.json { render :show, status: :created, location: @astrobin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @astrobin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /astrobins/1 or /astrobins/1.json
  def update
    respond_to do |format|
      if @astrobin.update(astrobin_params)
        format.html { redirect_to @astrobin, notice: "Astrobin was successfully updated." }
        format.json { render :show, status: :ok, location: @astrobin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @astrobin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /astrobins/1 or /astrobins/1.json
  def destroy
    @astrobin.destroy!

    respond_to do |format|
      format.html { redirect_to astrobins_path, status: :see_other, notice: "Astrobin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_astrobin
      @astrobin = Astrobin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def astrobin_params
      params.require(:astrobin).permit(:username, :latest_image)
    end
end
