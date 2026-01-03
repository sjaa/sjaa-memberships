class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy add_person import_csv ]
  include GoogleHelper

  # GET /groups or /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  def add_person
    success = false

    # Add the person to this group unless they are already in it
    if(params[:person_id])
      person = Person.find(params[:person_id])
      @group.people << person unless(@group.people.include?(person))
      success = true
    end

    respond_to do |format|
      if success
        format.html { redirect_to @group, notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_path, status: :see_other, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /groups/1/import_csv
  def import_csv
    unless params[:csv_file].present?
      redirect_to @group, alert: "Please select a CSV file to upload."
      return
    end

    # Get Google API authorization
    auth = get_auth(@user)
    if auth.nil?
      redirect_to @group, alert: "You must authenticate with Google first."
      return
    end

    csv_content = params[:csv_file].read

    # Check if this should be run as a background job
    if params[:background].present?
      ImportGroupCsvJob.perform_later(@group.id, csv_content, @user.id)
      redirect_to @group, notice: "CSV import has been queued as a background job. Check the logs for progress."
      return
    end

    # Run synchronously
    begin
      importer = GroupCsvImporter.new(group: @group, auth: auth, csv_content: csv_content)
      result = importer.import

      unless result[:success]
        redirect_to @group, alert: result[:error]
        return
      end

      # Build success message
      results = result[:results]
      message = []
      message << "Successfully added #{results[:added].count} member(s) to #{@group.email}." if results[:added].any?
      message << "#{results[:skipped].count} member(s) were already in the group." if results[:skipped].any?
      message << "Added #{results[:added_to_db].count} member(s) to the database group." if results[:added_to_db].any?
      message << "#{results[:errors].count} error(s) occurred." if results[:errors].any?

      if results[:errors].any?
        error_details = results[:errors].map { |e| "#{e[:email]}: #{e[:error]}" }.join(", ")
        redirect_to @group, alert: "#{message.join(' ')} Errors: #{error_details}"
      else
        redirect_to @group, notice: message.join(' ')
      end

    rescue => e
      Rails.logger.error "CSV Import Error: #{e.class.name} - #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to @group, alert: "An error occurred while importing: #{e.message}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:discord_id, :name, :short_name, :email, :joinable, :members_only)
    end
end
