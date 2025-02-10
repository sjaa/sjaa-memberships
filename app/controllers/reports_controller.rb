class ReportsController < ApplicationController
  include ReportsHelper
  include PeopleHelper

  def ephemeris
    filter({ephemeris: 'printed'})

    if(params[:page])
      render turbo_stream: turbo_stream.replace('people', partial: 'people/index')
      return
    end
  end
end