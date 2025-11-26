class WidgetController < ApplicationController
  layout 'widget'

  # Skip authentication for public widgets
  skip_before_action :authenticate!, only: [:meetup]

  def meetup
    @events = MeetupEvent.upcoming.limit(10)
  end
end
