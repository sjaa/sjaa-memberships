class StaticPagesController < ApplicationController
  skip_before_action :authenticate!

  def unauthorized
  end
end
