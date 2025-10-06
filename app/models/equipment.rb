class Equipment < ApplicationRecord
  belongs_to :instrument
  belongs_to :person, required: false
  belongs_to :role, required: false
  has_and_belongs_to_many :tags
  has_many_attached :images
  has_many :donation_items, dependent: :destroy
  has_many :donations, through: :donation_items
  include ItemCasable

  def to_html
    return "<strong>#{instrument&.kind&.titleize}</strong> #{instrument&.model}"
  end

  def instrument_attributes=(instrument_attr)
    _instrument_attr = instrument_attr.dup

    # Sanitize the strings
    caseitize_hash(_instrument_attr)
    self.instrument = Instrument.find_or_create_by(_instrument_attr)
  end

  def tag_attributes=(tag_names)
    logger.info("tags: #{tag_names}")
    local_tags = []
    tag_names.map{|t| t.downcase.strip}.uniq.select{|t| !t.empty?}.each do |name|
      tag = Tag.find_or_create_by(name: name)
      local_tags << tag
    end

    self.tags = local_tags
  end

  def donation_summary
    return nil if donation_items.empty?

    total_value = donation_items.sum { |item| item.value || 0 }
    donation_count = donations.count

    if donation_count == 1
      "Donated ($#{total_value})"
    else
      "#{donation_count} donations ($#{total_value})"
    end
  end
end
