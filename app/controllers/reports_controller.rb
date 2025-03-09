class ReportsController < ApplicationController
  include ReportsHelper
  include PeopleHelper

  def ephemeris
    filter({ephemeris: 'printed'})

    if(params[:page])
      render turbo_stream: turbo_stream.replace('people', partial: 'people/ephemeris_index')
      return
    end

    respond_to do |format|
      format.html
      format.csv do
        csv_data = CSV.generate(headers: true) do |csv|
          csv << ['First Name', 'Last Name', 'Address', 'City', 'State', 'Zip']
          @all_people.each do |person|
            csv << [
            person.first_name,
            person.last_name,
            person.primary_contact&.address,
            person.primary_contact&.city&.name,
            person.primary_contact&.state&.name,
            person.primary_contact&.zipcode,
            ]
          end
        end

        send_data csv_data, filename: "sjaa-ephemeris-#{Date.today}.csv"
      end
    end
  end

  def renewal_reminders
    @people = Person.renewable_members.sort_by{|person| person.latest_membership.end}

    if(params[:page])
      render turbo_stream: turbo_stream.replace('people', partial: 'people/index')
      return
    end
  end
end