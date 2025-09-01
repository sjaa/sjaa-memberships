class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Add some date checks
    #if Date.today.day == 1
      #AccountMailer.sample.deliver_now
      Rails.logger.info "Sample Job COMPLETE!! #{Time.now}"
    #end
  end

end
