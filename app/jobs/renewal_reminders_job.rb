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
        
        # Self-imposed rate-limiting
        sleep(1)
      end
    end
    
  end # perform
  
end
