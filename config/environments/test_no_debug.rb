# Test environment without debug server
require_relative 'test'

# Explicitly prevent debug server initialization
ENV['RUBY_DEBUG_OPEN'] = nil