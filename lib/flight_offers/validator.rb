# frozen_string_literal: true

module FlightOffers
  class Validator
    def initialize(flight_offer)
      @flight_offer = flight_offer
    end

    def confirm_flight_offer
      return unless inside_ticketing_period?

      flight_offer.update!(confirmed: true)
    end

    private

    attr_reader :flight_offer

    def inside_ticketing_period?
      flight_offer.last_ticketing_datetime > Time.now
    end

    def amadeus_client
      @client ||= Amadeus::Client.new()
    end
  end
end
