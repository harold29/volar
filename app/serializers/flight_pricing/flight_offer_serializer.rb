module FlightPricing
  class FlightOfferSerializer < BaseSerializer
    attributes :type,
               :id,
               :source,
               :instant_ticketing_required,
               :last_ticketing_date,
               :last_ticketing_date_time,
               :number_of_bookable_seats,
               :pricing_options,
               :validating_airline_codes

    has_many :itineraries, serializer: FlightPricing::ItinerarySerializer
    has_many :traveler_pricings, serializer: FlightPricing::TravelerPricingSerializer
    has_one :price, serializer: FlightPricing::PriceSerializer

    def type
      'flight-offer'
    end

    def id
      object.internal_id
    end

    def last_ticketing_date_time
      object.last_ticketing_datetime.strftime('%Y-%m-%dT%H:%M:%S')
    end

    def pricing_options
      # TODO: remove nil fields
      {
        fare_type: object.pricing_options_fare_type,
        included_checked_bags_only: object.pricing_options_included_checked_bags_only,
        refundable_fare: object.pricing_options_refundable_fare,
        no_restriction_fare: object.pricing_options_no_restriction_fare,
        no_penalty_fare: object.pricing_options_no_penalty_fare
      }
    end

    # def itineraries
    #   return unless instance_options[:depth].nil? || instance_options[:depth] > 0

    #   object.itineraries.map do |itinerary|
    #     FlightPricing::ItinerarySerializer.new(itinerary, scope:,
    #                                                       depth: instance_options[:depth] ? instance_options[:depth] - 1 : nil).serializable_hash
    #   end
    # end

    # def traveler_pricings
    #   return unless instance_options[:depth].nil? || instance_options[:depth] > 0

    #   object.traveler_pricings.map do |traveler_pricing|
    #     FlightPricing::TravelerPricingSerializer.new(traveler_pricing, scope:,
    #                                                                    depth: instance_options[:depth] ? instance_options[:depth] - 1 : nil).serializable_hash
    #   end
    # end
  end
end
