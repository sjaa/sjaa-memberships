module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Authenticatable
    #identified_by :current_user

    def connect
      #authenticate!
      #self.current_user = @current_user # maybe redundant
    end
  end
end
