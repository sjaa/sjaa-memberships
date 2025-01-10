require "test_helper"

class DonationItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donation_item = donation_items(:one)
  end

  test "should get index" do
    get donation_items_url
    assert_response :success
  end

  test "should get new" do
    get new_donation_item_url
    assert_response :success
  end

  test "should create donation_item" do
    assert_difference("DonationItem.count") do
      post donation_items_url, params: { donation_item: { value: @donation_item.value } }
    end

    assert_redirected_to donation_item_url(DonationItem.last)
  end

  test "should show donation_item" do
    get donation_item_url(@donation_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_donation_item_url(@donation_item)
    assert_response :success
  end

  test "should update donation_item" do
    patch donation_item_url(@donation_item), params: { donation_item: { value: @donation_item.value } }
    assert_redirected_to donation_item_url(@donation_item)
  end

  test "should destroy donation_item" do
    assert_difference("DonationItem.count", -1) do
      delete donation_item_url(@donation_item)
    end

    assert_redirected_to donation_items_url
  end
end
