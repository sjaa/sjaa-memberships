module ReportsHelper
  # to_csv
  #
  # Generate a CSV with the input models.  Optionally
  # provide a list of attributes to include.  Defaults
  # to all attributes
  def to_csv(models: [], attrs: [])
    sample = models.first
    return nil if(sample.nil?)

    _attrs = attrs&.empty? ? sample.attributes.keys : attrs

    CSV.generate(headers: true) do |csv|
      csv << _attrs
      models.each do |model|
        csv << _attrs.map{ |attr| model.attributes[attr] }
      end
    end
  end
end