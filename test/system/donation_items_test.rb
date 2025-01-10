require "application_system_test_case"

class DonationItemsTest < ApplicationSystemTestCase
  setup do
    @donation_item = donation_items(:one)
  end

  test "visiting the index" do
    visit donation_items_url
    assert_selector "h1", text: "Donation items"
  end

  test "should create donation item" do
    visit donation_items_url
    click_on "New donation item"

    fill_in "Value", with: @donation_item.value
    click_on "Create Donation item"

    assert_text "Donation item was successfully created"
    click_on "Back"
  end

  test "should update Donation item" do
    visit donation_item_url(@donation_item)
    click_on "Edit this donation item", match: :first

    fill_in "Value", with: @donation_item.value
    click_on "Update Donation item"

    assert_text "Donation item was successfully updated"
    click_on "Back"
  end

  test "should destroy Donation item" do
    visit donation_item_url(@donation_item)
    click_on "Destroy this donation item", match: :first

    assert_text "Donation item was successfully destroyed"
  end
end
