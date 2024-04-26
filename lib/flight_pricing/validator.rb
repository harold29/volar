module FlightPricing
  class Validator
    def initialize(flight_offers)
      @flight_offers = flight_offers
    end

    def validate
      return unless inside_ticketing_period?

      response = amadeus_client.post_flight_pricing(build_request_params)
      parsed_response = ResponseParser.parse(response, flight_offers)

      flight_offers.each do |flight_offer|
        flight_offer.update(parsed_response)
      end
    end

    private

    attr_reader :flight_offers

    def update_flight_offers(response)
      flight_offers.each do |flight_offer|
        flight_offer.price.update(response[:price])
        flight_offer.traveler_pricings.each do |traveler_pricing|
          response[:traveler_pricings_attributes].each do |response_traveler_pricing|
            if traveler_pricing.traveler_internal_id == response_traveler_pricing[:traveler_internal_id]
              traveler_pricing.price.update(response_traveler_pricing[:price_attributes])
            end
          end
        end
      end
    end

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
