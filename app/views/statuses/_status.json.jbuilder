json.extract! status, :id, :name, :short_name, :created_at, :updated_at
json.url status_url(status, format: :json)
