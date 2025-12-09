class HomeController < ApplicationController
  skip_before_action :policy_handling

  def index
    # Redirect members without admin permissions to their profile
    if current_user.is_a?(Person) && !current_user.has_permission?(:read)
      redirect_to person_path(current_user), notice: 'Welcome back! Here is your profile.'
    else
      # Redirect admins and members with read permission to the people directory
      redirect_to people_path
    end
  end
end
