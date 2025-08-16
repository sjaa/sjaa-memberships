class Equipment < ApplicationRecord
  belongs_to :instrument
  belongs_to :person, required: false
  has_many_attached :images
  include ItemCasable

  def to_html
    return "<strong>#{instrument&.kind&.titleize}</strong> #{instrument&.model} #{note ? '(' + note + ')' : ''}"
  end

  def instrument_attributes=(instrument_attr)
    _instrument_attr = instrument_attr.dup

    # Sanitize the strings
    caseitize_hash(_instrument_attr)
    self.instrument = Instrument.find_or_create_by(_instrument_attr)
  end
end
