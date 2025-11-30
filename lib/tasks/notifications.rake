namespace :notifications do
  desc "Clean up old notifications (default: older than 10 days)"
  task :cleanup, [:days] => :environment do |t, args|
    days = args[:days]&.to_i || 10

    puts "Cleaning up notifications older than #{days} days..."

    count = Notification.cleanup_old_notifications(days)

    puts "Deleted #{count} old notifications."
  end

  desc "Clean up all read notifications"
  task :cleanup_read => :environment do
    puts "Cleaning up all read notifications..."

    count = Notification.read.destroy_all.count

    puts "Deleted #{count} read notifications."
  end

  desc "Show notification statistics"
  task :stats => :environment do
    puts "\n=== Notification Statistics ==="
    puts "Total notifications: #{Notification.count}"
    puts "Unread notifications: #{Notification.unread.count}"
    puts "Read notifications: #{Notification.read.count}"
    puts "\nBy Category:"
    Notification.group(:category).count.each do |category, count|
      puts "  #{category}: #{count}"
    end
    puts "\nBy Priority:"
    Notification.group(:priority).count.each do |priority, count|
      puts "  #{priority}: #{count}"
    end
    puts "\nOldest notification: #{Notification.order(:created_at).first&.created_at || 'N/A'}"
    puts "Newest notification: #{Notification.order(:created_at).last&.created_at || 'N/A'}"
    puts "================================\n"
  end
end
