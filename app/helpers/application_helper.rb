module ApplicationHelper
  include Pagy::Frontend

  def date_format(d)
    begin
      return d.strftime('%Y-%m-%d')
    rescue
    end
  end

  def ephemeris_format(e)
    e ? 'PRINT' : 'DIGITAL'
  end

  def dollar_format(d)
    "$#{sprintf("%.02f", d)}"
  end
end
