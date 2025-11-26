class WidgetController < ApplicationController
  layout 'widget'

  # Skip authentication for public widgets
  skip_before_action :authenticate!, only: [:meetup]
  before_action :allow_cross_origin, if: :embeddable?

  def allow_cross_origin
    headers['Access-Control-Allow-Origin'] = '*'
  end

  def embeddable?
    request.headers['X-Frame-Options'].present?
  end

  def meetup
    response.headers['Content-Type'] = 'text/html'
    response.headers['X-Frame-Options'] = 'ALLOW-FROM https://sites.google.com'
    @events = MeetupEvent.upcoming.limit(10)
  end
end
