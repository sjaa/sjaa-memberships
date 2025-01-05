json.extract! contact, :id, :address, :city_id, :state_id, :zipcode, :phone, :email, :primary, :person_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)
