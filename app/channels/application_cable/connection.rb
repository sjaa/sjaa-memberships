module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.class.name, current_user.id
    end

    private

    def find_verified_user
      # Get the session cookie
      cookie = cookies.encrypted[Rails.application.config.session_options[:key]]

      if cookie.present?
        # Try to find admin first
        if verified_admin = Admin.find_by(id: cookie['admin_id'])
          return verified_admin
        # Then try person
        elsif verified_person = Person.find_by(id: cookie['person_id'])
          return verified_person
        end
      end

      reject_unauthorized_connection
    end
  end
end
