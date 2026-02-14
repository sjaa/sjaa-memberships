class StaticPagesController < ApplicationController
  skip_before_action :authenticate!, only: [:unauthorized]

  def unauthorized
  end

  def document_archive
  end
end
