class RenewalRemindersJob < ApplicationJob
  queue_as :default
  include JobsHelper

  def perform(*args)
    enable = args[0].downcase.strip == 'enable'
    schedule = args[1]

    if(enable && schedule_match(schedule))
      # Iterate over renewable members
      Person.renewable_members.each do |person|
        # Send individual reminders
        AccountMailer.renewal_notice(person).deliver_now

        # Send real-time notification to member
        if person.latest_membership&.end
          days_until_expiration = (person.latest_membership.end.to_date - Date.today).to_i
          NotificationBroadcaster.membership_renewal_reminder(person, days_until_expiration)
        end

        # Self-imposed rate-limiting
        sleep(1)
      end
    end

  end # perform

end
