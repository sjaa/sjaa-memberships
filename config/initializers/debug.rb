# Debug configuration for Docker remote debugging
# Note: Tests use docker compose run with RUBY_DEBUG_OPEN= to disable this
if Rails.env.development? && 
   ENV['RUBY_DEBUG_OPEN'] && 
   !ENV['RUBY_DEBUG_OPEN'].empty? &&
   ENV['RUBY_DEBUG_OPEN'] != 'false'
  puts "🐛 Starting debug server on #{ENV['RUBY_DEBUG_HOST']}:#{ENV['RUBY_DEBUG_PORT']}"
  require 'debug/open_nonstop'
end