class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # Stream notifications specific to the current user
    stream_for current_user

    # Send initial unread count when user connects
    transmit_unread_count
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def mark_as_read(data)
    notification = Notification.find_by(id: data['id'])
    if notification && notification.recipient == current_user
      notification.mark_as_read!
      transmit_unread_count
    end
  end

  def mark_all_as_read
    Notification.for_user(current_user).unread.update_all(unread: false)
    transmit_unread_count
  end

  private

  def transmit_unread_count
    count = Notification.for_user(current_user).unread.count
    transmit({ type: 'unread_count', count: count })
  end
end
