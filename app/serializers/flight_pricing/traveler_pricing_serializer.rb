module FlightPricing
  class TravelerPricingSerializer < BaseSerializer
    attributes :traveler_id,
               :fare_option,
               :traveler_type,
               :price

    has_many :fare_details_by_segments, serializer: FlightPricing::FareDetailsBySegmentSerializer

    def traveler_id
      object.traveler_internal_id
    end

    def price
      {
        base: object.price_base,
        total: object.price_total,
        currency: object.price_currency.code
      }
    end
  end
end
