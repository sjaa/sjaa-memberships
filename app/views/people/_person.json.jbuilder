json.extract! person, :id, :first_name, :last_name, :astrobin, :notes, :interests, :memberships, :donations, :roles, :discord_id, :referral, :created_at, :updated_at
json.url person_url(person, format: :json)
