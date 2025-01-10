class Equipment < ApplicationRecord
  belongs_to :instrument
  belongs_to :person

  def to_html
    return "<strong>#{instrument&.name}</strong> #{model} #{note ? '(' + note + ')' : ''}"
  end
end
