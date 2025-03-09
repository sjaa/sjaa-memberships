class SyncJob < ApplicationJob
  queue_as :default

  def perform(*args)
    id_hash = args[0]
    sleep 5 # just an example
    # Setup a notification now that it is complete
    notification = Notification.create(id_hash.merge({message: "Job is done!  Sent to user #{id_hash.inspect}"}))
    ActionCable.server.broadcast "NotificationChannel", {message: notification.message}
  end
end
