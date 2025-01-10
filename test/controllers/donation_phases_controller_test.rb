require "test_helper"

class DonationPhasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donation_phase = donation_phases(:one)
  end

  test "should get index" do
    get donation_phases_url
    assert_response :success
  end

  test "should get new" do
    get new_donation_phase_url
    assert_response :success
  end

  test "should create donation_phase" do
    assert_difference("DonationPhase.count") do
      post donation_phases_url, params: { donation_phase: { date: @donation_phase.date, name: @donation_phase.name } }
    end

    assert_redirected_to donation_phase_url(DonationPhase.last)
  end

  test "should show donation_phase" do
    get donation_phase_url(@donation_phase)
    assert_response :success
  end

  test "should get edit" do
    get edit_donation_phase_url(@donation_phase)
    assert_response :success
  end

  test "should update donation_phase" do
    patch donation_phase_url(@donation_phase), params: { donation_phase: { date: @donation_phase.date, name: @donation_phase.name } }
    assert_redirected_to donation_phase_url(@donation_phase)
  end

  test "should destroy donation_phase" do
    assert_difference("DonationPhase.count", -1) do
      delete donation_phase_url(@donation_phase)
    end

    assert_redirected_to donation_phases_url
  end
end
