# Debug configuration for Docker remote debugging
if Rails.env.development? && ENV['RUBY_DEBUG_OPEN']
  puts "🐛 Starting debug server on #{ENV['RUBY_DEBUG_HOST']}:#{ENV['RUBY_DEBUG_PORT']}"
  require 'debug/open_nonstop'
end