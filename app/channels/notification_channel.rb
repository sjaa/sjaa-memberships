class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "NotificationChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
