json.extract! person, :id, :first_name, :last_name, :astrobin_id, :notes, :membership_id, :discord_id, :referral_id, :created_at, :updated_at
json.url person_url(person, format: :json)
