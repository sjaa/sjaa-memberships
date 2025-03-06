class SyncJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep 5 # just an example
    ActionCable.server.broadcast "NotificationChannel", "Job is done!"
  end
end
