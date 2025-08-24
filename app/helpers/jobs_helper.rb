module JobsHelper
  # Decode a simplified cron-like schedule
  # Month Day Hour
  def schedule_match(schedule)
    return true if(schedule.nil?)
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