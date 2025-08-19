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

  def display_tag(tag: nil, editable: false, form: false)
    return if tag.nil?

    style = "background-color: #{tag.color}; color: #{contrasting_color(tag.color)}; font-weight: bold;"
    icon = tag.icon ? "<i class=\"bi bi-#{tag.icon}\"></i>" : ''
    link = editable ? edit_tag_path(tag) : tag
    str = <<-EOF
      <span id="tags_#{tag.id}" class="d-inline-block mt-2" style="margin-right: 0.5em;">
    EOF
    if(form)
      str += <<-EOF
        #{hidden_field_tag 'equipment[tag_attributes][]', tag.name}
        <a data-form-id-param="tags_#{tag.id}" data-action="form#removeField" class="btn" style="#{style}">#{icon.html_safe}#{tag.name.titleize}</a>
      EOF
    else
      str += <<-EOF
        #{link_to(link, class: 'btn', style: style){"#{icon.html_safe}#{tag.name.titleize}"}}
      EOF
    end

    str += "</span>"
    return str.html_safe
  end

  def contrasting_color(hex)
    return "#000000" if hex.nil?

    # Remove the '#' if present
    hex = hex.delete_prefix('#')

    # Convert hex to RGB components
    r = hex[0..1].to_i(16)
    g = hex[2..3].to_i(16)
    b = hex[4..5].to_i(16)

    # Calculate luminance using the Rec. 709 formula
    luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b

    # Return white for dark colors, black for light colors
    luminance < 128 ? '#ffffff' : '#000000'
  end

end
