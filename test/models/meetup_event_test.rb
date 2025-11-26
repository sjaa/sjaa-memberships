require "test_helper"

class MeetupEventTest < ActiveSupport::TestCase
  test "should create meetup event with valid attributes" do
    event = MeetupEvent.new(
      meetup_id: "test123",
      title: "Test Meetup",
      url: "https://meetup.com/test",
      time: 1.day.from_now
    )
    assert event.save
  end

  test "should require meetup_id" do
    event = MeetupEvent.new(title: "Test", time: Time.current)
    assert_not event.save
    assert_includes event.errors[:meetup_id], "can't be blank"
  end

  test "should require unique meetup_id" do
    MeetupEvent.create!(meetup_id: "duplicate", title: "First", time: Time.current)
    event = MeetupEvent.new(meetup_id: "duplicate", title: "Second", time: Time.current)
    assert_not event.save
    assert_includes event.errors[:meetup_id], "has already been taken"
  end

  test "upcoming scope should return future events" do
    past_event = MeetupEvent.create!(meetup_id: "past1", title: "Past", time: 1.day.ago)
    future_event = MeetupEvent.create!(meetup_id: "future1", title: "Future", time: 1.day.from_now)

    upcoming = MeetupEvent.upcoming
    assert_includes upcoming, future_event
    assert_not_includes upcoming, past_event
  end

  test "past scope should return past events" do
    past_event = MeetupEvent.create!(meetup_id: "past2", title: "Past", time: 1.day.ago)
    future_event = MeetupEvent.create!(meetup_id: "future2", title: "Future", time: 1.day.from_now)

    past = MeetupEvent.past
    assert_includes past, past_event
    assert_not_includes past, future_event
  end
end
