class PeopleController < ApplicationController
  include ReportsHelper
  include Filterable
  include GoogleHelper

  before_action :set_person, only: %i[ show edit update destroy new_membership  remind approve_mentorship deny_mentorship]
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

  def bulk_add_to_groups
    person_ids = params[:person_ids] || []
    group_ids = params[:group_ids] || []

    if person_ids.empty? || group_ids.empty?
      render json: { error: 'Please select at least one person and one group' }, status: :unprocessable_entity
      return
    end

    people = Person.where(id: person_ids)
    groups = Group.where(id: group_ids)

    added_count = 0
    people.each do |person|
      groups.each do |group|
        unless person.groups.include?(group)
          person.groups << group
          added_count += 1
        end
      end
    end

    render json: {
      message: "Successfully added #{people.count} people to #{groups.count} group(s). #{added_count} new group memberships created.",
      added_count: added_count,
      people_count: people.count,
      groups_count: groups.count
    }
  end

  # POST /people/:id/approve_mentorship
  def approve_mentorship
    if @person.approve_mentorship!
      redirect_to @person, notice: "#{@person.name} has been approved as a mentor."
    else
      redirect_to @person, alert: "Failed to approve mentorship."
    end
  end

  # POST /people/:id/deny_mentorship
  def deny_mentorship
    if @person.deny_mentorship!
      redirect_to @person, notice: "Mentorship approval for #{@person.name} has been denied."
    else
      redirect_to @person, alert: "Failed to deny mentorship."
    end
  end

  # GET /people/verify
  def verify_form
    @verification_result = nil
  end

  # POST /people/verify
  def verify
    email = params[:email]&.strip&.downcase
    @verification_result = { timestamp: Time.current.strftime("%B %d, %Y at %I:%M %p") }

    if email.blank?
      @verification_result[:error] = "Email address is required"
      render :verify_form, status: :unprocessable_entity
      return
    end

    person = Person.find_by_email(email)

    if person.nil?
      @verification_result[:valid] = false
      @verification_result[:message] = "No member found with this email address"
    else
      latest_membership = person.latest_membership
      if latest_membership&.is_active?
        @verification_result[:valid] = true
        @verification_result[:message] = "Valid Member"
        @verification_result[:expires] = latest_membership.end&.strftime("%B %Y") || "Lifetime"
      else
        @verification_result[:valid] = false
        @verification_result[:message] = "Membership Expired"
        @verification_result[:expires] = latest_membership&.end&.strftime("%B %Y")
      end
    end

    render :verify_form
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
        flash.now[:alert] = "Problem creating person: <ul>#{@person.errors.full_messages.map{|er| "<li>#{er}</li>"}.join('  ')}</ul>"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /people/1 or /people/1.json
  def update
    # Track which groups the person belonged to before the update
    old_group_ids = @person.groups.pluck(:id)

    respond_to do |format|
      begin
        update_success = @person.update(person_params)
      rescue => e
        update_success = false
        @person.errors.add :exception, e.message
      end

      if update_success && !@person.errors.any?
        # Enforce members_only restriction on groups
        removed_groups = enforce_members_only_groups

        # Sync Google Groups if groups changed
        new_group_ids = @person.groups.pluck(:id)
        if old_group_ids.sort != new_group_ids.sort
          sync_google_groups_for_person(@person, old_group_ids, new_group_ids)
        end

        # Build appropriate flash message
        if removed_groups.any?
          group_names = removed_groups.map(&:name).join(', ')
          notice_message = "Profile was successfully updated. However, you were removed from the following members-only groups because your membership has expired: <strong>#{group_names}</strong>. Please renew your membership to rejoin these groups."
        else
          notice_message = "Profile was successfully updated."
        end

        format.html { redirect_to @person, notice: notice_message }
        format.json { render :show, status: :ok, location: @person }
      else
        flash.now[:alert] = "Problem updating person: <ul>#{@person.errors.full_messages.map{|er| "<li>#{er}</li>"}.join('  ')}</ul>"
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

  # Enforce members_only restriction on groups
  # Removes any members_only groups if the person doesn't have an active membership
  # Returns array of removed groups
  def enforce_members_only_groups
    # Check if person has an active membership
    is_active = @person.is_active?

    # Reload to get the freshest group associations after update
    @person.reload

    # Get all groups the person is currently in
    current_groups = @person.groups.to_a

    # Find groups that are members_only and person is not active
    restricted_groups = current_groups.select { |group| group.members_only && !is_active }

    if restricted_groups.any?
      # Remove the person from members_only groups
      @person.groups = current_groups - restricted_groups
      @person.save!

      # Log which groups were removed
      removed_group_names = restricted_groups.map(&:name).join(', ')
      Rails.logger.info "[PeopleController] Removed non-active member #{@person.id} from members_only groups: #{removed_group_names}"
    end

    # Return the list of removed groups
    restricted_groups
  end

  # Sync person's Google Groups memberships based on group changes
  def sync_google_groups_for_person(person, old_group_ids, new_group_ids)
    # Only sync if we have a person with an email
    return unless person.email.present?

    # Find an admin with Google credentials
    admin = @user.is_a?(Admin) && @user.refresh_token.present? ? @user : Admin.where.not(refresh_token: nil).first
    return unless admin&.refresh_token.present?

    begin
      # Get Google API authorization
      auth = get_auth(admin)
      client = Google::Apis::AdminDirectoryV1::DirectoryService.new
      client.authorization = auth

      # Determine which groups were added and removed
      added_group_ids = new_group_ids - old_group_ids
      removed_group_ids = old_group_ids - new_group_ids

      # Get the actual group records that have Google Group emails
      groups_to_add = Group.where(id: added_group_ids).where.not(email: [nil, ''])
      groups_to_remove = Group.where(id: removed_group_ids).where.not(email: [nil, ''])

      # Add person to new groups
      groups_to_add.each do |group|
        begin
          member = Google::Apis::AdminDirectoryV1::Member.new(
            email: person.email,
            role: 'MEMBER',
            type: 'USER'
          )
          client.insert_member(group.email, member)
          Rails.logger.info "[PeopleController] Added #{person.email} to Google Group: #{group.email}"
        rescue Google::Apis::ClientError => e
          # Ignore duplicate member errors
          unless e.status_code == 409 || e.message.include?("Member already exists")
            Rails.logger.error "[PeopleController] Failed to add #{person.email} to #{group.email}: #{e.message}"
          end
        end
      end

      # Remove person from old groups
      groups_to_remove.each do |group|
        begin
          client.delete_member(group.email, person.email)
          Rails.logger.info "[PeopleController] Removed #{person.email} from Google Group: #{group.email}"
        rescue Google::Apis::ClientError => e
          # Ignore "member not found" errors
          unless e.status_code == 404 || e.message.include?("Resource Not Found")
            Rails.logger.error "[PeopleController] Failed to remove #{person.email} from #{group.email}: #{e.message}"
          end
        end
      end

    rescue => e
      Rails.logger.error "[PeopleController] Failed to sync Google Groups for person #{person.id}: #{e.message}"
      # Don't fail the update if Google sync fails
    end
  end
  
  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(
    :first_name, :last_name, :astrobin_id, :notes, :membership_id, :discord_id, :referral_id, :volunteer, :mentor, :mentor_description, :profile_picture,
    interests_attributes: [:name, :id],
    groups_attributes: [:id],
    joinable_group_ids: [],
    permission_attributes: [],
    skills_attributes: [:skill_id, :skill_level, :interest_level],
    contact_attributes: [:address, :zipcode, :phone, :state_id, :city_id, :city_name, :email, :primary, :person_id, :id],
    membership_attributes: [:start, :kind, :kind_id, :term_months, :new, :ephemeris, :id, :person_id, :donation_amount, :author, order_attributes: [:payment_method]],
    astrobin_attributes: [:username, :latest_image, :id],
    telescopius_attributes: [:username, :id])
  end
  
  def policy_handling
    begin
      set_person
      #puts("Authorizing #{@person.inspect}")
      authorize @person, policy_class: PersonPolicy
    rescue => e
      #puts("Person not set! #{e.message}")
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
