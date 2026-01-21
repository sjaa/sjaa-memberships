# frozen_string_literal: true

# Configure DocumentArchive engine to use the main app's authentication
# by inheriting from the main ApplicationController
Rails.application.config.to_prepare do
  DocumentArchive::ApplicationController.include Authenticatable
  DocumentArchive::ApplicationController.include Pundit::Authorization

  DocumentArchive::ApplicationController.class_eval do
    prepend_before_action :authenticate!
  end
end
