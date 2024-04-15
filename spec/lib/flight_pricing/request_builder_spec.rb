require 'rails_helper'

RSpec.describe FlightPricing::RequestBuilder do
  describe '#build_request' do
    # subject { described_class.new(flight_offer_objects).build_request }

    # let(:flight_offer_objects) { [flight_offer_object] }
    # let(:flight_offer_object) { instance_double(FlightOffer, internal_id: 'internal_id') }

    it 'returns a hash with the correct structure' do
      # potato = create(:flight_offer)
      # nuclear = FlightPricing::FlightOfferSerializer.new(potato)
      # baz = nuclear.to_json
      # puts baz

      # bar = create(:itinerary)
      # nuclear = FlightPricing::ItinerarySerializer.new(bar)
      # foo = nuclear.to_json
      # puts foo

      # azul = create(:segment)
      # verde = FlightPricing::SegmentSerializer.new(azul)
      # amarelo = verde.to_json
      # puts amarelo

      # byebug
      # expect(subject).to eq(
      #   data: {
      #     type: 'flight-offers-pricing',
      #     flightOffers: [
      #       {
      #         type: 'flight-offer',
      #         id: 'internal_id',
      #         source: nil,
      #         instant_ticketing_required: nil,
      #         last_ticketing_date: nil,
      #         last_ticketing_date_time: nil,
      #         number_of_bookable_seats: nil,
      #         itineraries: [],
      #         price: nil,
      #         pricing_options: {
      #           fare_type: nil,
      #           included_checked_bags_only: nil,
      #           refundable_fare: nil,
      #           no_restriction_fare: nil,
      #           no_penalty_fare: nil
      #         },
      #         validating_airline_codes: nil,
      #         traveler_pricings: []
      #       }
      #     ]
      #   }
      # )
    end
  end
end
