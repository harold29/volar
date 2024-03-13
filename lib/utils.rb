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

  def snake_case(string)
    string.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase
  end

  def generate_app_composed_id
    ''
  end
end
