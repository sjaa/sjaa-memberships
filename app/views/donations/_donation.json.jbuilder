json.extract! donation, :id, :date, :value, :note, :person_id, :created_at, :updated_at
json.url donation_url(donation, format: :json)
