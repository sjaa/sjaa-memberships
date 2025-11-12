json.extract! person, :id, :email, :first_name, :last_name, :astrobin, :notes, :interests, :memberships, :donations, :groups, :discord_id, :referral, :created_at, :updated_at
json.url person_url(person, format: :json)
