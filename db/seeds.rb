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

# Actual admin
admin = Admin.create(email: 'vp@sjaa.net', password: 'secret')
admin.permissions += [PERMISSION_HASH['read'], PERMISSION_HASH['write'], PERMISSION_HASH['permit']]

# Actual roles
roles = {'Member' => nil, 'Contact' => nil}.map{|n,e| Role.create(name: n, email: e, short_name: n.split(' ').map(&:first).join.upcase)}
