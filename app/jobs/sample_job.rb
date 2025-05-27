class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AccountMailer.sample.deliver_now
  end

end
