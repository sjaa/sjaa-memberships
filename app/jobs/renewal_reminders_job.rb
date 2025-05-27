class RenewalRemindersJob < ApplicationJob
  queue_as :default
  
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
  
  # Decode a simplified cron-like schedule
  # Month Day Hour
  def schedule_match(schedule)
    today = DateTime.now
    schedule_mdh = schedule.split(' ')
    today_mdh = [today.month, today.day, today.hour]
    comparison = true
    
    today_mdh.each_with_index do |unit, index|
      sched = schedule_mdh[index]
      #puts "sched: #{sched} index: #{index} unit: #{unit} comparison: #{comparison}"
      comparison = comparison && (sched.nil? || sched == '*' || sched.to_i == unit)
    end
    
    return comparison
  end
  
end
