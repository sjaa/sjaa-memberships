module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Authenticatable
    #identified_by :current_user
    #attr_accessor :session

    def connect
      #self.session ||= cookies.encrypted['_session_id']
      #authenticate
      #self.current_user = @current_user # maybe redundant
    end
  end
end
