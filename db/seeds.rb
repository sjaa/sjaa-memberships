# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require_relative('./sjaa_port')
include SjaaPort

# Application configuration
# These values should be updated with actual credentials after deployment
puts "Creating application configuration..."

# Create all configs from definitions (does not update existing configs)
AppConfig::DEFINITIONS.each do |definition|
  AppConfig.find_or_create_by!(key: definition[:key]) do |c|
    c.value = ENV.fetch(definition[:env], definition[:default])
    c.category = definition[:category]
    c.description = definition[:description]
    c.encrypted = definition[:encrypted]
  end
end

puts "Application configuration created successfully!"
