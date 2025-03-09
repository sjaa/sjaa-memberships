json.extract! notification, :id, :message, :person_id, :admin_id, :unread, :created_at, :updated_at
json.url notification_url(notification, format: :json)
