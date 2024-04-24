module FlightPricing
  class Validator
    def initialize(flight_offers)
      @flight_offers = flight_offers
    end

    def validate
      return unless inside_ticketing_period?

      response = amadeus_client.post_flight_pricing(build_request_params)

      parsed_response = ResponseParser.parse(response, flight_offers)
    end

    private

    attr_reader :flight_offers

    def inside_ticketing_period?
      flight_offer.first.last_ticketing_datetime > Time.now # TODO: one single flight offer?
    end

    def build_request_params
      RequestBuilder.new(flight_offers).build_request
    end

    def amadeus_client
      @amadeus_client ||= Amadeus::Client.new
    end
  end
end
