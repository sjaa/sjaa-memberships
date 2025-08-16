module ItemCasable
  extend ActiveSupport::Concern
  def caseitize
    self.kind = self.kind&.downcase
    self.model = self.model&.upcase
  end

  def caseitize_hash(attributes)
    attributes['kind'] = attributes.dig('kind')&.downcase
    attributes['model'] = attributes.dig('model')&.upcase
  end
end