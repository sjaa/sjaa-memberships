class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]
  
  # GET /people or /people.json
  def index
    filter
    render partial: 'index' if(params[:page])
  end
  
  # GET /people/1 or /people/1.json
  def show
  end
  
  def search
    filter
    render turbo_stream: turbo_stream.replace('people', partial: 'index')
  end
  
  # GET /people/new
  def new
    @person = Person.new
    @person.interests.build
  end
  
  # GET /people/1/edit
  def edit
  end
  
  # POST /people or /people.json
  def create
    @person = Person.new(person_params)
    
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params) && !@person.errors.any?
        format.html { redirect_to @person, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        flash[:error] = "Problem updating person: #{@person.errors.full_messages.join('  ')}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy!
    
    respond_to do |format|
      format.html { redirect_to people_path, status: :see_other, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
  def filter
    query = Person.all.includes(:donations, :memberships, :contacts, :interests, :status)
    query = query.where(Person.arel_table[:first_name].matches("%#{params[:first_name]}%")) if(params[:first_name].present?)
    query = query.where(Person.arel_table[:last_name].matches("%#{params[:last_name]}%")) if(params[:last_name].present?)
    query = query.joins(:contacts).where(Contact.arel_table[:email].matches("%#{params[:email]}%")) if(params[:email].present?)
    query = query.joins(:contacts).where(Contact.arel_table[:phone].matches("%#{params[:phone]}%")) if(params[:phone].present?)
    query = query.joins(contacts: :city).where(City.arel_table[:name].matches("%#{params[:city]}%")) if(params[:city].present?)
    query = query.joins(contacts: :state).where(State.arel_table[:short_name].matches("%#{params[:state]}%")) if(params[:state].present?)
    query = query.joins(:status).where(Status.arel_table[:name].matches("%#{params[:status]}%")) if(params[:status].present?)
    
    @query_params = params.dup
    @query_params.delete(:authenticity_token)
    @query_params.delete(:submit)
    @query_params.select!{|k,v| v.present?}
    @query_params = @query_params.permit(:first_name, :last_name, :email, :phone, :city, :state, :status)
    
    @pagy, @people = pagy(query, limit: 40)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(
    :first_name, :last_name, :astrobin_id, :notes, :membership_id, :discord_id, :referral_id, :status_id,
    interests_attributes: [:name, :id], 
    contact_attributes: [:address, :zipcode, :phone, :state_id, :city_id, :city_name, :email, :primary, :person_id, :id], 
    membership_attributes: [:start, :kind, :kind_id, :term_months, :new, :ephemeris, :id, :person_id],
    astrobin_attributes: [:username, :latest_image, :id])
  end
end
