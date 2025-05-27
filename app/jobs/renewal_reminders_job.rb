class RenewalRemindersJob < ApplicationJob
  queue_as :default

  def perform_test_thingy(*args)
    AccountMailer.sample.deliver_now
  end

  def perform(*args)
    # Iterate over renewable members
    Person.renewable_members.each do |person|
      # Send individual reminders
      AccountMailer.renewal_notice(person).deliver_now

      # Self-imposed rate-limiting
      sleep(1)
    end
  end
end
