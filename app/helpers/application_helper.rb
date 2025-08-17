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
    return '' if(!d.present?)
    "$#{sprintf("%.02f", d)}"
  end

  def table(opts = {}, &block)
    str = <<-EOF
    <div class="table-responsive">
      <table #{opts.map{|k,v| "#{k}=\"#{v}\""}.join(' ')}>
    EOF
    str += capture(&block)
    str += <<-EOF
      </table>
    </div>
    EOF

    return str.html_safe
  end

  # Use for assigning prefix (if present) to a field
  def attributize(prefix: nil, field: nil)
    return prefix.nil? ? field&.to_s : "#{prefix}[#{field}]"
  end

  def julian_date(date)
    date ||= Date.today
    return "#{date.year}#{sprintf("%3d", date.yday)}"
  end
end
