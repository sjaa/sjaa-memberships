class StaticPagesController < ApplicationController
  skip_before_action :authorize!

  def unauthorized
  end
end
