class PeopleController < ApplicationController
  include ReportsHelper
  include Filterable

  before_action :set_person, only: %i[ show edit update destroy new_membership  remind]
  skip_before_action :verify_authenticity_token, only: [:update], if: -> { request.format.json? }
  
  # GET /people or /people.json
  def index
    people_filter
    respond_to do |format|
      format.html
      format.json
      format.csv { send_data people_to_sjaa_db(@all_people), filename: "sjaa-people-#{Date.today}.csv" }
    end
  end
  
  # GET /people/1 or /people/1.json
  def show
  end

  def admin
  end

  def remind
    AccountMailer.renewal_notice(@person).deliver_now
    redirect_to @person, notice: 'Reminder email sent.'
  end

  def remind_all
    RenewalRemindersJob.perform_later('enable')
    flash[:notice] = 'Reminders Sent.'
    redirect_to people_path
  end

  def welcome
    AccountMailer.welcome(@person.latest_membership).deliver_now
    redirect_to @person, notice: 'Welcome email sent.'
  end

  def new_membership
    if(@person&.is_lifetime_member)
      redirect_to @person, alert: 'You are a LIFETIME member - no need to renew!'
    end
  end

  def create_membership
  end
  
  def search
    people_filter
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
        format.html { redirect_to @person, notice: "Profile was successfully created." }
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
      begin
        update_success = @person.update(person_params)
      rescue => e
        update_success = false
        @person.errors.add :exception, e.message
      end

      if update_success && !@person.errors.any?
        format.html { redirect_to @person, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        flash[:alert] = "Problem updating person: <ul>#{@person.errors.full_messages.map{|er| "<li>#{er}</li>"}.join('  ')}</ul>"
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
  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(
    :first_name, :last_name, :astrobin_id, :notes, :membership_id, :discord_id, :referral_id,
    interests_attributes: [:name, :id], 
    roles_attributes: [:id], 
    contact_attributes: [:address, :zipcode, :phone, :state_id, :city_id, :city_name, :email, :primary, :person_id, :id], 
    membership_attributes: [:start, :kind, :kind_id, :term_months, :new, :ephemeris, :id, :person_id, :donation_amount, :author, order_attributes: [:payment_method]],
    astrobin_attributes: [:username, :latest_image, :id])
  end
  
  def policy_handling
    begin
      set_person
      puts("Authorizing #{@person.inspect}")
      authorize @person, policy_class: PersonPolicy
    rescue => e
      puts("Person not set! #{e.message}")
      authorize self.class, policy_class: PersonPolicy
    end
  end

  def people_to_sjaa_db(people)
    csv = CSV.generate(headers: true) do |csv|
      csv << ["First Name", "Last Name", "Status", "Expiry Date", 
      "last payment", 'Cash?', 'Term', 
      'Type', 'New/Rtn', 'Member Since', 'Ephem', 'Comp', 'email1', 
      'Address1', 'City1', 'ST1', 'Zip1', 'phone1', 'email2', 'phone2', 
      "Observer's Group?", "Observers Email Address (if diff)", "Interests", "Equipment"]


      people.each do |person|
        term = person.latest_membership&.term_years
        csv << [
          person.first_name, person.last_name, person.is_active? ? 'Member' : 'Expired', person.latest_membership&.end&.strftime('%m-%d-%Y') || 'Life', 
          person.latest_membership&.start&.strftime('%m-%d-%Y') || '', '',  term ? "#{term}yr" : '',
          person.latest_membership&.kind&.name, person.latest_membership == person.first_membership ? 'New' : 'Rtn', person.first_membership&.start&.strftime('%m-%d-%Y') || '', person.latest_membership&.ephemeris ? 'PRINT' : '', person.latest_membership&.end.nil? ? 'Lifetime' : '', person.contacts.first&.email || '',
          person.contacts.first&.address || '', person.contacts.first&.city&.name || '', person.contacts.first&.state&.short_name || '', person.contacts.first&.zipcode || '', person.contacts.first&.phone || '', person.contacts.second&.email || '', person.contacts.second&.phone || '',
          '', '', person.interests.map(&:name).join(", "), person.notes
        ]
      end
    end

    csv
  end
end
