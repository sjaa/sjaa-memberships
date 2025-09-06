require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = Person.create!(
      first_name: "John",
      last_name: "Doe",
      password: "password123",
      signup_completed: true
    )
    
    @contact = Contact.create!(
      email: "john@example.com",
      person: @person,
      primary: true
    )
    
    @existing_membership = Membership.create!(
      person: @person,
      start: 1.year.ago,
      term_months: 12,
      ephemeris: false
    )
    
    # Stub PayPal environment constants
    unless Rails.application.config.respond_to?(:paypal_mode)
      Rails.application.config.paypal_mode = :sandbox
    end
    
    # Set up SjaaMembers constants if not defined
    unless defined?(SjaaMembers::YEARLY_MEMBERSHIP_RATE)
      stub_const('SjaaMembers::YEARLY_MEMBERSHIP_RATE', 75.0)
    end
    unless defined?(SjaaMembers::EPHEMERIS_FEE)
      stub_const('SjaaMembers::EPHEMERIS_FEE', 10.0)
    end
  end

  test "should get memberships index" do
    get memberships_url
    assert_response :success
  end

  test "should show membership" do
    get membership_url(@existing_membership)
    assert_response :success
  end

  test "should get new membership form" do
    get new_membership_url
    assert_response :success
  end

  test "should create membership with valid params" do
    assert_difference("Membership.count") do
      post memberships_url, params: {
        membership: {
          person_id: @person.id,
          start: Date.current,
          term_months: 12,
          ephemeris: false,
          new: false
        }
      }
    end
    
    assert_redirected_to membership_url(Membership.last)
    assert_equal "Membership was successfully created.", flash[:notice]
  end

  test "should update existing membership" do
    patch membership_url(@existing_membership), params: {
      membership: {
        ephemeris: true
      }
    }
    
    assert_redirected_to membership_url(@existing_membership)
    assert_equal "Membership was successfully updated.", flash[:notice]
    
    @existing_membership.reload
    assert @existing_membership.ephemeris
  end

  test "should delete membership" do
    assert_difference("Membership.count", -1) do
      delete membership_url(@existing_membership)
    end
    
    assert_redirected_to memberships_url
    assert_equal "Membership was successfully destroyed.", flash[:notice]
  end

  test "create_order calculates correct price for basic membership" do
    setup_paypal_mocks
    
    post membership_order_url, params: {
      membership: {
        person_id: @person.id,
        ephemeris_amount: "0",
        donation_amount: "0"
      }
    }
    
    assert_response :success
    response_body = JSON.parse(@response.body)
    assert response_body["token"]
    
    order = Order.last
    assert_equal SjaaMembers::YEARLY_MEMBERSHIP_RATE, order.price
  end

  test "create_order calculates correct price with ephemeris" do
    setup_paypal_mocks
    
    post membership_order_url, params: {
      membership: {
        person_id: @person.id,
        ephemeris_amount: SjaaMembers::EPHEMERIS_FEE.to_s,
        donation_amount: "0"
      }
    }
    
    assert_response :success
    order = Order.last
    expected_price = SjaaMembers::YEARLY_MEMBERSHIP_RATE + SjaaMembers::EPHEMERIS_FEE
    assert_equal expected_price, order.price
    assert order.membership_params["ephemeris"]
  end

  test "create_order calculates correct price with donation" do
    setup_paypal_mocks
    
    donation_amount = 25.0
    post membership_order_url, params: {
      membership: {
        person_id: @person.id,
        ephemeris_amount: "0",
        donation_amount: donation_amount.to_s
      }
    }
    
    assert_response :success
    order = Order.last
    expected_price = SjaaMembers::YEARLY_MEMBERSHIP_RATE + donation_amount
    assert_equal expected_price, order.price
    assert_equal donation_amount.to_s, order.membership_params["donation_amount"]
  end

  test "create_order sets correct membership start date for new member" do
    setup_paypal_mocks
    
    new_person = Person.create!(
      first_name: "Jane",
      last_name: "Smith",
      password: "password123",
      signup_completed: true
    )
    
    post membership_order_url, params: {
      membership: {
        person_id: new_person.id,
        ephemeris_amount: "0",
        donation_amount: "0"
      }
    }
    
    assert_response :success
    order = Order.last
    assert_equal Date.today, Date.parse(order.membership_params["start"])
  end

  test "create_order sets correct membership start date for renewing member" do
    setup_paypal_mocks
    
    # Create current active membership
    current_membership = Membership.create!(
      person: @person,
      start: Date.current.beginning_of_month,
      term_months: 12,
      ephemeris: false
    )
    
    post membership_order_url, params: {
      membership: {
        person_id: @person.id,
        ephemeris_amount: "0",
        donation_amount: "0"
      }
    }
    
    assert_response :success
    order = Order.last
    expected_start = current_membership.end.beginning_of_month
    assert_equal expected_start, Date.parse(order.membership_params["start"])
  end

  test "capture_order completes membership creation and sends welcome email" do
    order = Order.create!(
      price: SjaaMembers::YEARLY_MEMBERSHIP_RATE,
      token: "test_paypal_token",
      paid: false,
      membership_params: {
        "person_id" => @person.id,
        "start" => Date.current.to_s,
        "term_months" => 12,
        "ephemeris" => false,
        "new" => false
      }
    )
    
    setup_paypal_capture_mocks(order.token)
    
    assert_difference("Membership.count") do
      assert_emails 1 do
        post membership_capture_order_url, params: {
          order_id: order.token
        }
      end
    end
    
    assert_response :success
    response_body = JSON.parse(@response.body)
    assert_equal "COMPLETED", response_body["status"]
    assert response_body["redirect"].include?("people")
    
    order.reload
    assert order.paid
    
    membership = Membership.last
    assert_equal @person, membership.person
    assert_equal order, membership.order
  end

  test "capture_order handles PayPal errors gracefully" do
    order = Order.create!(
      price: 75.0,
      token: "failing_token",
      paid: false,
      membership_params: {
        "person_id" => @person.id,
        "start" => Date.current.to_s,
        "term_months" => 12
      }
    )
    
    setup_paypal_error_mocks
    
    post membership_capture_order_url, params: {
      order_id: order.token  
    }
    
    assert_response :error
    response_body = JSON.parse(@response.body)
    assert response_body["error"]
  end

  test "membership params are properly filtered" do
    post memberships_url, params: {
      membership: {
        person_id: @person.id,
        start: Date.current,
        term_months: 12,
        ephemeris: true,
        new: false,
        malicious_param: "should_be_filtered"
      }
    }
    
    membership = Membership.last
    assert_not_respond_to membership, :malicious_param
  end

  private

  def setup_paypal_mocks
    # Mock PayPal SDK calls
    mock_response = OpenStruct.new(
      result: OpenStruct.new(id: "mock_order_id_#{SecureRandom.hex(8)}")
    )
    
    mock_client = OpenStruct.new
    def mock_client.execute(request)
      OpenStruct.new(
        result: OpenStruct.new(id: "PAYPAL_ORDER_#{SecureRandom.hex(8)}")
      )
    end
    
    # Stub the PayPal client creation
    PayPal::PayPalHttpClient.stubs(:new).returns(mock_client)
  end

  def setup_paypal_capture_mocks(order_token)
    mock_response = OpenStruct.new(
      result: OpenStruct.new(status: "COMPLETED")
    )
    
    mock_client = OpenStruct.new
    def mock_client.execute(request)
      OpenStruct.new(
        result: OpenStruct.new(status: "COMPLETED")
      )
    end
    
    PayPal::PayPalHttpClient.stubs(:new).returns(mock_client)
  end

  def setup_paypal_error_mocks
    mock_client = OpenStruct.new  
    def mock_client.execute(request)
      raise PayPalHttp::HttpError.new("Payment failed", 400, {}, "Bad request")
    end
    
    PayPal::PayPalHttpClient.stubs(:new).returns(mock_client)
  end

  def stub_const(const_name, value)
    const_parts = const_name.split('::')
    if const_parts.length == 2
      mod = const_parts[0].constantize rescue nil
      if mod.nil?
        Object.const_set(const_parts[0], Module.new)
        mod = const_parts[0].constantize
      end
      mod.const_set(const_parts[1], value) unless mod.const_defined?(const_parts[1])
    end
  rescue
    Object.const_set(const_name.gsub('::', '_'), value) unless Object.const_defined?(const_name.gsub('::', '_'))
  end
end