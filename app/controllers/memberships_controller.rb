class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[ show edit update destroy ]
  before_action :paypal_init, only: %i[ create_order capture_order ]
  skip_before_action :verify_authenticity_token, only: %i[ capture_order ]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @membership = Membership.new(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: "Membership was successfully created." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # Called from people/:id/new_mebership
  #  First step in the PayPal order processing flow
  def create_order
    mp = membership_params.dup
    ephemeris_amount = mp.delete(:ephemeris_amount)
    mp[:ephemeris] = true if(ephemeris_amount.to_f > 0)
    mp[:start] = DateTime.now

    price = SjaaMembers::YEARLY_MEMBERSHIP_RATE
    price += mp[:donation_amount].to_f if(mp[:donation_amount].present?)
    price += SjaaMembers::EPHEMERIS_FEE if(mp[:ephemeris])

    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => "#{price}"
          }
        }
      ]
    })
  
    begin
      response = @client.execute request
      order = Order.new
      order.price = price
      order.token = response.result.id

      order.membership_params = mp

      if order.save
        return render :json => {:token => response.result.id, membership: mp}, :status => :ok
      else
        return render :json => {error: "Could not process membership order.  Please try later."}, :status => :error
      end
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
      return render :json => {error: "PayPal Error: #{ioe}"}, :status => :error
    end
  end

  # Second step in the PayPal order processing flow
  def capture_order
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]

    begin
      response = @client.execute request
      order = Order.find_by :token => params[:order_id]
      order.paid = response.result.status == 'COMPLETED'
      membership = Membership.new(order.membership_params)
      membership.order = order
  
      if order.save && membership.save
        return render :json => {:status => response.result.status, redirect: person_path(membership.person)}, :status => :ok
      else
        return render :json => {:error => (order.errors.full_messages + membership.errors.full_messages).join('  ')}, :status => :error
      end
    rescue PayPalHttp::HttpError => ioe
      return render :json => {:error => ioe.to_s}, :status => :error
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @membership.destroy!

    respond_to do |format|
      format.html { redirect_to memberships_path, status: :see_other, notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def membership_params
      params.require(:membership).permit(:start, :term_months, :ephemeris, :new, :type, :status_id, :person_id, :ephemeris_amount, :donation_amount)
    end

    def paypal_init
      client_id = ENV['PAYPAL_CLIENT_ID']
      client_secret = ENV['PAYPAL_CLIENT_SECRET']
      environment = PayPal::SandboxEnvironment.new client_id, client_secret
      @client = PayPal::PayPalHttpClient.new environment
    end
end
