class Equipment < ApplicationRecord
  belongs_to :instrument
  belongs_to :person, required: false

  def to_html
    return "<strong>#{instrument&.kind&.titleize}</strong> #{instrument&.model} #{note ? '(' + note + ')' : ''}"
  end

  def instrument_attributes=(instrument_attr)
    self.instrument = Instrument.find_or_create_by(instrument_attr)
  end
end
