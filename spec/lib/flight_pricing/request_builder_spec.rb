require 'rails_helper'

RSpec.describe FlightPricing::RequestBuilder do
  describe '#build_request' do
    subject { described_class.new(flight_offer_objects).build_request }

    let(:flight_offer_objects) { [flight_offer_object] }
    let(:flight_offer_object) { create(:flight_offer) }
    let(:serialized_flight_offers) do
      ActiveModelSerializers::SerializableResource.new(flight_offer_objects,
                                                       { each_serializer: FlightPricing::FlightOfferSerializer,
                                                         include: '**' }).serializable_hash
    end

    it 'returns a hash with the correct main structure' do
      expect(subject).to include(
        {
          data: {
            type: 'flight-offers-pricing',
            flightOffers: a_kind_of(Array)
          }
        }
      )
    end

    context 'returns a hash with the correct internal structure' do
      it 'returns a hash with the correct main structure' do
        flight_offer_data = subject[:data][:flightOffers].first

        expect(flight_offer_data).to include({
                                               type: 'flight-offer',
                                               id: flight_offer_object.internal_id,
                                               source: flight_offer_object.source,
                                               instant_ticketing_required: flight_offer_object.instant_ticketing_required,
                                               last_ticketing_date: flight_offer_object.last_ticketing_date,
                                               last_ticketing_date_time: flight_offer_object.last_ticketing_datetime.strftime('%Y-%m-%dT%H:%M:%S'),
                                               number_of_bookable_seats: flight_offer_object.number_of_bookable_seats,
                                               itineraries: a_kind_of(Array),
                                               price: a_kind_of(Hash),
                                               pricing_options: a_kind_of(Hash),
                                               validating_airline_codes: flight_offer_object.validating_airline_codes,
                                               traveler_pricings: a_kind_of(Array)
                                             })
      end

      it 'returns a hash with the correct itineraries structure' do
        itineraries = subject[:data][:flightOffers].first[:itineraries].first

        expect(itineraries).to include({
                                         duration: flight_offer_object.itineraries.first.duration,
                                         segments: a_kind_of(Array)
                                       })
      end

      it 'returns a hash with the correct price structure' do
        price = subject[:data][:flightOffers].first[:price]

        expect(price).to include({
                                   currency: flight_offer_object.price.price_currency.code,
                                   total: flight_offer_object.price.price_total,
                                   base: flight_offer_object.price.base_fare,
                                   fees: a_kind_of(Array),
                                   grand_total: flight_offer_object.price.price_grand_total
                                 })
      end

      it 'returns a hash with the correct pricing_options structure' do
        pricing_options = subject[:data][:flightOffers].first[:pricing_options]

        expect(pricing_options).to include({
                                             fare_type: flight_offer_object.pricing_options_fare_type,
                                             included_checked_bags_only: flight_offer_object.pricing_options_included_checked_bags_only,
                                             refundable_fare: flight_offer_object.pricing_options_refundable_fare,
                                             no_restriction_fare: flight_offer_object.pricing_options_no_restriction_fare,
                                             no_penalty_fare: flight_offer_object.pricing_options_no_penalty_fare
                                           })
      end

      it 'returns a hash with the correct traveler_pricings structure' do
        traveler_pricings = subject[:data][:flightOffers].first[:traveler_pricings].first

        expect(traveler_pricings).to include({
                                               traveler_id: flight_offer_object.traveler_pricings.first.traveler_internal_id,
                                               fare_option: flight_offer_object.traveler_pricings.first.fare_option,
                                               traveler_type: flight_offer_object.traveler_pricings.first.traveler_type,
                                               price: a_kind_of(Hash),
                                               fare_details_by_segments: a_kind_of(Array)
                                             })
      end

      context 'for the fare_details_by_segments' do
        it 'returns a hash with the correct fare_details_by_segments structure' do
          fare_details_by_segments = subject[:data][:flightOffers].first[:traveler_pricings].first[:fare_details_by_segments].first

          expect(fare_details_by_segments).to include({
                                                        segment_id: flight_offer_object.traveler_pricings.first.fare_details_by_segments.first.segment_internal_id,
                                                        cabin: flight_offer_object.traveler_pricings.first.fare_details_by_segments.first.cabin,
                                                        fare_basis: flight_offer_object.traveler_pricings.first.fare_details_by_segments.first.fare_basis,
                                                        branded_fare: flight_offer_object.traveler_pricings.first.fare_details_by_segments.first.branded_fare,
                                                        branded_fare_label: flight_offer_object.traveler_pricings.first.fare_details_by_segments.first.branded_fare_label,
                                                        included_checked_bags: {
                                                          quantity: flight_offer_object.traveler_pricings.first.fare_details_by_segments.first.included_checked_bags
                                                        },
                                                        amenities: a_kind_of(Array)
                                                      })
        end
      end
    end
  end
end
