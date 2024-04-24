module Utils
  def deep_snake_case_keys(value)
    case value
    when Array
      value.map { |v| deep_snake_case_keys(v) }
    when Hash
      value.map { |k, v| [snake_case(k.to_s).to_sym, deep_snake_case_keys(v)] }.to_h
    else
      value
    end
  end

  # def deep_compact(hash)
  #   hash.each_with_object({}) do |(key, value), new_hash|
  #     next if value.nil?

  #     new_hash[key] = value.is_a?(Hash) ? deep_compact(value) : value
  #   end
  # end
  def deep_compact(item)
    case item
    when Hash
      item.each_with_object({}) do |(key, value), new_hash|
        next if value.nil?

        cleaned_value = deep_compact(value) # Recursively clean each value
        new_hash[key] = cleaned_value unless cleaned_value.nil? || (cleaned_value.respond_to?(:empty?) && cleaned_value.empty?)
      end
    when Array
      item.map { |value| deep_compact(value) } # Recursively clean each element in the array
          .compact.reject(&:empty?)
    else
      item # Return the item itself if it is neither a Hash nor an Array
    end
  end

  def snake_case(string)
    string.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase
  end

  %i[airport currency carrier].each do |key|
    define_method("#{key}") do |code|
      variable_name = "@#{key}"
      object = instance_variable_get(variable_name)

      search_attribute = key == :airport ? :iata_code : :code

      return object if object.present? && object.send(search_attribute) == code

      object = key.to_s.capitalize.constantize.find_by(search_attribute => code)
      instance_variable_set(variable_name, object)
    end
  end
end
