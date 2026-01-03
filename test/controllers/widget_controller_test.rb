require "test_helper"

class WidgetControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create an admin to bypass the setup wizard
    Admin.create!(email: 'test@sjaa.net', password: 'password123') if Admin.count == 0
  end

  test "should get meetup widget without authentication" do
    get widget_meetup_path
    assert_response :success
  end

  test "should display upcoming events" do
    # Create some test events
    MeetupEvent.create!(
      meetup_id: "test1",
      title: "Future Event",
      url: "https://meetup.com/test1",
      time: 1.day.from_now
    )

    MeetupEvent.create!(
      meetup_id: "test2",
      title: "Past Event",
      url: "https://meetup.com/test2",
      time: 1.day.ago
    )

    get widget_meetup_path
    assert_response :success
    assert_select "div.meetup-widget"
    assert_select "div.list-group"
    assert_match "Future Event", response.body
    assert_no_match "Past Event", response.body
  end

  test "should show message when no upcoming events" do
    get widget_meetup_path
    assert_response :success
    assert_match "No upcoming Meetup events scheduled", response.body
  end

  test "should use widget layout" do
    get widget_meetup_path
    assert_response :success
    assert_select "title", "SJAA Widget"
    # Should not have navigation
    assert_select "nav.navbar", false
  end
end
