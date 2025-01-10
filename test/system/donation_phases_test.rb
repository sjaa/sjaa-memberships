require "application_system_test_case"

class DonationPhasesTest < ApplicationSystemTestCase
  setup do
    @donation_phase = donation_phases(:one)
  end

  test "visiting the index" do
    visit donation_phases_url
    assert_selector "h1", text: "Donation phases"
  end

  test "should create donation phase" do
    visit donation_phases_url
    click_on "New donation phase"

    fill_in "Date", with: @donation_phase.date
    fill_in "Name", with: @donation_phase.name
    click_on "Create Donation phase"

    assert_text "Donation phase was successfully created"
    click_on "Back"
  end

  test "should update Donation phase" do
    visit donation_phase_url(@donation_phase)
    click_on "Edit this donation phase", match: :first

    fill_in "Date", with: @donation_phase.date
    fill_in "Name", with: @donation_phase.name
    click_on "Update Donation phase"

    assert_text "Donation phase was successfully updated"
    click_on "Back"
  end

  test "should destroy Donation phase" do
    visit donation_phase_url(@donation_phase)
    click_on "Destroy this donation phase", match: :first

    assert_text "Donation phase was successfully destroyed"
  end
end
