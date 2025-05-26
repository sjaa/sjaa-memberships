class RenewalRemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Iterate over renewable members
    Person.renewable_members.each do |person|
      # Send individual reminders
      AccountMailer.renewal_notice(person)
    end
  end
end
