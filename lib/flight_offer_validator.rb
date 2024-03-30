# frozen_string_literal: true

class FlightOfferValidator
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
    @client ||= Amadeus::Client.new(
      client_id: ENV['AMADEUS_CLIENT_ID'],
      client_secret: ENV['AMADEUS_CLIENT_SECRET']
    )
  end
end
