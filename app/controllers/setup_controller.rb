class SetupController < ApplicationController
  skip_before_action :authenticate!, only: [:index]
  skip_before_action :policy_handling, only: [:index]

  def index
    # If admins already exist, redirect to login
    if Admin.count > 0
      redirect_to login_path, notice: "Application is already configured."
    end
    # Otherwise, show the setup instructions view
  end
end
