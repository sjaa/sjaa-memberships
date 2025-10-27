module Sanitizable
  extend ActiveSupport::Concern
  
  def sanitize(params_hash)
    params_hash.transform_values do |value|
      value.is_a?(String) ? value.strip : value
    end
  end
end
