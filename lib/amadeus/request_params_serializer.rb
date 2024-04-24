module Amadeus
  class RequestParamsSerializer
    NOT_ALLOWED_FIELDS = %i[one_way].freeze

    # def self.serialize(input_hash)
    #   return {} if input_hash.empty?

    #   input_hash.to_h.each_with_object({}) do |(key, value), result|
    #     next if NOT_ALLOWED_FIELDS.include?(key.to_sym)

    #     new_key = case key.to_sym
    #               when :currency_id
    #                 'currencyCode'
    #               when :origin
    #                 'originLocationCode'
    #               when :destination
    #                 'destinationLocationCode'
    #               when :nonstop
    #                 'nonStop'
    #               else
    #                 camelize(key.to_s)
    #               end

    #     new_value = case key.to_sym
    #                 when :currency_id
    #                   get_currency_code(value)
    #                 else
    #                   value
    #                 end
    #     result[new_key] = new_value
    #   end
    # end

    # def self.get_currency_code(value)
    #   if value.instance_of?(String)
    #     if value.length == 3
    #       value
    #     else
    #       Currency.find_by_id(value)&.code
    #     end
    #   elsif value.instance_of?(Currency)
    #     value.code
    #   end
    # end

    # def self.camelize(str)
    #   str.split('_').each_with_index.reduce('') do |acc, (part, index)|
    #     acc + (index.zero? ? part : part.capitalize)
    #   end
    # end

    def self.serialize(input_hash)
      return {} if input_hash.empty?

      input_hash.to_h.each_with_object({}) do |(key, value), result|
        next if NOT_ALLOWED_FIELDS.include?(key.to_sym)

        new_key = map_key(key)
        result[new_key] = map_value(key, value)
      end
    end

    def self.map_key(key)
      case key.to_sym
      when :currency_id
        'currencyCode'
      when :origin
        'originLocationCode'
      when :destination
        'destinationLocationCode'
      when :nonstop
        'nonStop'
      else
        camelize(key.to_s)
      end
    end

    def self.map_value(key, value)
      if value.is_a?(Hash)
        serialize(value) # Recursive call for nested hashes
      elsif value.is_a?(Array)
        value.map { |v| v.is_a?(Hash) ? serialize(v) : v } # Recursive call for each hash in the array
      else
        format_simple_value(key, value)
      end
    end

    def self.format_simple_value(key, value)
      case key.to_sym
      when :currency_id
        get_currency_code(value)
      else
        value
      end
    end

    def self.get_currency_code(value)
      if value.is_a?(String)
        value.length == 3 ? value : Currency.find_by_id(value)&.code
      elsif value.is_a?(Currency)
        value.code
      else
        value # Just return the value if it's neither a string nor a Currency object
      end
    end

    def self.camelize(str)
      str.split('_').each_with_index.reduce('') do |acc, (part, index)|
        acc + (index.zero? ? part : part.capitalize)
      end
    end
  end
end
