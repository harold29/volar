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
  end
end
