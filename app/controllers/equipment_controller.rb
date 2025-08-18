class EquipmentController < ApplicationController
  before_action :set_equipment, only: %i[ show edit update destroy ]
  include Resizable
  
  # GET /equipment or /equipment.json
  def index
    filter
  end
  
  def search
    filter
    render turbo_stream: turbo_stream.replace('equipment', partial: 'index')
  end
  
  # GET /equipment/1 or /equipment/1.json
  def show
  end
  
  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end
  
  # GET /equipment/1/edit
  def edit
  end
  
  # POST /equipment or /equipment.json
  def create
    @equipment = Equipment.new(equipment_params.except(:images))
    
    respond_to do |format|
      if @equipment.save
        resize_and_attach(images: equipment_params[:images], object: @equipment)
        format.html { redirect_to @equipment, notice: "Equipment was successfully created." }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /equipment/1 or /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params.except(:images))
        if(equipment_params[:images])
          resize_and_attach(images: equipment_params[:images], object: @equipment)
        end
        format.html { redirect_to @equipment, notice: "Equipment was successfully updated." }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /equipment/1 or /equipment/1.json
  def destroy
    @equipment.destroy!
    
    respond_to do |format|
      format.html { redirect_to equipment_index_path, status: :see_other, notice: "Equipment was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
  def filter
    @query_params = params.dup
    @query_params.delete(:authenticity_token)
    @query_params.delete(:submit)
    @query_params.select!{|k,v| v.present?}
    @query_params = @query_params.permit(:kind_name, :model_name, :person_id, :group_id, :note)
    qp = @query_params
    
    query = Equipment.all.includes(:instrument)
    query = query.where(instrument: {kind: qp[:kind_name]}) if(qp[:kind_name].present?)
    query = query.where(person_id: qp[:person_id]) if(qp[:person_id].present?)
    equipment = query
    
    @pagy, @equipment = pagy(equipment, limit: 40, params: @query_params.to_h)
  end
  
  
  # Use callbacks to share common setup or constraints between actions.
  def set_equipment
    @equipment = Equipment.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def equipment_params
    params.require(:equipment).permit(:note, :person_id, :role_id, instrument_attributes: [:kind, :model], images: [], tag_attributes: [])
  end
end
