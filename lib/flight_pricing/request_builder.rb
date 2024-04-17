module FlightPricing
  class RequestBuilder
    def initialize(flight_offer_objects)
      @flight_offer_objects = flight_offer_objects
    end

    def build_request
      {
        data: {
          type: 'flight-offers-pricing',
          flightOffers: serialized_flight_offers
        }
      }
    end

    private

    attr_reader :flight_offer_objects

    def serialized_flight_offers
      ActiveModelSerializers::SerializableResource.new(flight_offer_objects,
                                                       { each_serializer: FlightPricing::FlightOfferSerializer,
                                                         include: '**' }).serializable_hash
    end

    # def flight_offers
    #   flight_offer_objects.map do |flight_offer|
    #     {
    #       type: 'flight-offer',
    #       id: flight_offer.internal_id,
    #       source: flight_offer.source,
    #       instant_ticketing_required: flight_offer.instant_ticketing_required,
    #       last_ticketing_date: flight_offer.last_ticketing_date,
    #       last_ticketing_date_time: flight_offer.last_ticketing_datetime.strftime('%Y-%m-%dT%H:%M:%S'),
    #       number_of_bookable_seats: flight_offer.number_of_bookable_seats,
    #       itineraries: itineraries(flight_offer.itineraries),
    #       price: price(flight_offer.price),
    #       pricing_options: {
    #         fare_type: flight_offer.pricing_options_fare_type,
    #         included_checked_bags_only: flight_offer.pricing_options_included_checked_bags_only,
    #         refundable_fare: flight_offer.pricing_options_refundable_fare,
    #         no_restriction_fare: flight_offer.pricing_options_no_restriction_fare,
    #         no_penalty_fare: flight_offer.pricing_options_no_penalty_fare
    #       },
    #       validating_airline_codes: flight_offer.validating_airline_codes,
    #       traveler_pricings: traveler_pricings(flight_offer.traveler_pricings)
    #     }
    #   end
    # end

    # def itineraries(itineraries)
    #   itineraries.map do |itinerary|
    #     {
    #       duration: itinerary.duration,
    #       segments: segments(itinerary.segments)
    #     }
    #   end
    # end

    # def segments(segments)
    #   segments.map do |segment|
    #     {
    #       departure: {
    #         iata_code: segment.departure_airport.iata_code,
    #         terminal: segment.departure_terminal,
    #         at: segment.departure_at.strftime('%Y-%m-%dT%H:%M:%S')
    #       },
    #       arrival: {
    #         iata_code: segment.arrival_airport.iata_code,
    #         terminal: segment.arrival_terminal,
    #         at: segment.arrival_at.strftime('%Y-%m-%dT%H:%M:%S')
    #       },
    #       carrier_code: segment.carrier.code,
    #       number: segment.flight_number,
    #       aircraft: {
    #         code: segment.aircraft_code
    #       },
    #       operating: {
    #         carrier_code: segment.carrier.code
    #       },
    #       duration: segment.duration,
    #       number_of_stops: segment.stops_number,
    #       stops: stops(segment.stops),
    #       id: segment.internal_id,
    #       blacklisted_in_EU: segment.blacklisted_in_eu
    #     }
    #   end
    # end

    # def stops(stops)
    #   stops.map do |stop|
    #     {
    #       iata_code: stop.airport.iata_code,
    #       duration: stop.duration,
    #       arrival_at: stop.arrival_at.strftime('%Y-%m-%dT%H:%M:%S'),
    #       departure_at: stop.departure_at.strftime('%Y-%m-%dT%H:%M:%S')
    #     }
    #   end
    # end

    # def price(price)
    #   {
    #     currency: price.price_currency.code,
    #     base: price.base_fare, # TODO: check if this field is filled
    #     total: price.price_total,
    #     grand_total: price.price_grand_total,
    #     fees: fees(price.fees)
    #     # additional_services: additional_services(price.additional_services)
    #   }
    # end

    # def fees(fees)
    #   fees.map do |fee|
    #     {
    #       amount: fee.fee_amount,
    #       type: fee.fee_type
    #     }
    #   end
    # end

    # def additional_services(additional_services)
    #   additional_services.map do |additional_service|
    #     {
    #       type: additional_service.service_type,
    #       amount: additional_service.service_amount
    #     }
    #   end
    # end

    # def traveler_pricings(traveler_pricings)
    #   traveler_pricings.map do |traveler_pricing|
    #     {
    #       traveler_id: traveler_pricing.traveler_internal_id,
    #       fare_option: traveler_pricing.fare_option,
    #       traveler_type: traveler_pricing.traveler_type,
    #       price: {
    #         base: traveler_pricing.price_base,
    #         total: traveler_pricing.price_total,
    #         currency: traveler_pricing.price_currency.code
    #       },
    #       fare_details_by_segment: fare_details_by_segment(traveler_pricing.fare_details_by_segments)
    #     }
    #   end
    # end

    # def fare_details_by_segment(fare_details_by_segments)
    #   fare_details_by_segments.map do |fare_detail_by_segment|
    #     {
    #       segment_id: fare_detail_by_segment.segment_internal_id,
    #       cabin: fare_detail_by_segment.cabin,
    #       fare_basis: fare_detail_by_segment.fare_basis,
    #       branded_fare: fare_detail_by_segment.branded_fare,
    #       branded_fare_label: fare_detail_by_segment.branded_fare_label,
    #       class: fare_detail_by_segment.class,
    #       included_checked_bags: {
    #         quantity: fare_detail_by_segment.included_checked_bags
    #       },
    #       # additional_services: additional_services(fare_detail_by_segment.additional_services), TODO: enable additional services
    #       amenities: amenities(fare_detail_by_segment.amenities)
    #     }
    #   end
    # end

    # def amenities(amenities)
    #   amenities.map do |amenity|
    #     {
    #       description: amenity.description,
    #       is_chargeable: amenity.is_chargeable,
    #       amenity_type: amenity.amenity_type,
    #       amenity_provider: {
    #         name: amenity.amenity_provider_name
    #       }
    #     }
    #   end
    # end
  end
end
