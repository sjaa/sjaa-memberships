# app/validators/strip_validator.rb
class StripValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.is_a?(String)
    
    stripped_value = value.strip
    
    # Remove extra internal whitespace if option is set
    stripped_value = stripped_value.squeeze(' ') if options[:squeeze]
    stripped_value = stripped_value.downcase if options[:downcase]
    
    # Update the attribute with cleaned value
    record.send("#{attribute}=", stripped_value)
    
    # Optional validations after stripping
    if options[:presence] && stripped_value.blank?
      record.errors.add(attribute, :blank)
    end
    
    if options[:minimum] && stripped_value.length < options[:minimum]
      record.errors.add(attribute, :too_short, count: options[:minimum])
    end
  end
end