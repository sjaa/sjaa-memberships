class Equipment < ApplicationRecord
  belongs_to :instrument
  belongs_to :person, ->{ includes(:instrument) }, required: false

  def to_html
    return "<strong>#{instrument&.kind&.titleize}</strong> #{instrument&.model} #{note ? '(' + note + ')' : ''}"
  end
end
