module FlightPricing
  class PriceSerializer < BaseSerializer
    attributes :currency,
               :total,
               :base,
               :grand_total

    has_many :fees, serializer: FlightPricing::FeeSerializer

    def currency
      object.price_currency.code
    end

    def total
      object.price_total
    end

    def base
      object.base_fare
    end

    def grand_total
      object.price_grand_total
    end

    # def fees
    #   return unless instance_options[:depth].nil? || instance_options[:depth] > 0

    #   object.fees.map do |fee|
    #     FlightPricing::FeeSerializer.new(fee, scope:, depth: instance_options[:depth] ? instance_options[:depth] - 1 : nil).serializable_hash
    #   end
    # end
  end
end
