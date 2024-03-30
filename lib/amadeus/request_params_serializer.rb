module Amadeus
  class RequestParamsSerializer
    NOT_ALLOWED_FIELDS = %i[one_way].freeze

    def self.serialize(input_hash)
      return {} if input_hash.empty?

      input_hash.to_h.each_with_object({}) do |(key, value), result|
        next if NOT_ALLOWED_FIELDS.include?(key.to_sym)

        new_key = case key.to_sym
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
        new_value = case key.to_sym
                    when :currency_id
                      get_currency_code(value)
                    else
                      value
                    end
        result[new_key] = new_value
      end
    end

    def self.get_currency_code(value)
      if value.instance_of?(String)
        if value.length == 3
          value
        else
          Currency.find_by_id(value)&.code
        end
      elsif value.instance_of?(Currency)
        value.code
      end
    end

    def self.camelize(str)
      str.split('_').each_with_index.reduce('') do |acc, (part, index)|
        acc + (index.zero? ? part : part.capitalize)
      end
    end
  end
end
