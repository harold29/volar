require 'rails_helper'

RSpec.describe FlightPricing::Validator do
  describe '#validate' do
    let(:us_currency) { create(:currency, code: 'USD') }
    let(:flight_offer) { create(:flight_offer, last_ticketing_datetime: Time.now + 20) }
    let(:client) { Amadeus::Client.new }
    let(:general_parameters) do
      {
        origin: 'LHR',
        destination: 'CDG',
        departure_date: '2025-01-01',
        return_date: '2025-01-10',
        adults: 2,
        children: 1,
        infants: 1,
        travel_class: 'ECONOMY',
        currency_id: us_currency.id,
        nonstop: 'false',
        one_way: 'false'
      }
    end
    let(:include_bags) { false }
    let(:include_additional_services) { false }
    let(:fixed_request) { {} } # Used in shared context to send request

    include_context 'set countries - currencies - airport - carrier'
    include_context 'post flight offer request and response no include'

    let(:response_data) { JSON.parse(fixed_response)['data']['flightOffers'].first }

    let(:validated) { described_class.validate([flight_offer]) }

    context '#validate' do
      describe 'when response is valid' do
        context 'updates flight_offer.price fields' do
          it 'updates price total field' do
            expect { validated }.to change { flight_offer.reload.price.price_total.to_f }.to(response_data['price']['total'].to_f)
          end

          it 'updates price base field' do
            expect { validated }.to change { flight_offer.reload.price.base_fare.to_f }.to(response_data['price']['base'].to_f)
          end

          it 'updates price grand total field' do
            expect { validated }.to change { flight_offer.reload.price.price_grand_total.to_f }.to(response_data['price']['grandTotal'].to_f)
          end

          describe 'updates price fees' do
            before do
              flight_offer.price.fees[0].update(fee_type: 'SUPPLIER')
              flight_offer.price.fees[1].update(fee_type: 'TICKETING')
              flight_offer.price.fees[2].update(fee_type: 'FORM_OF_PAYMENT')
              flight_offer.traveler_pricings[0].update(traveler_internal_id: '1')
              flight_offer.traveler_pricings[1].update(traveler_internal_id: '2')
              flight_offer.traveler_pricings[2].update(traveler_internal_id: '3')
            end

            it 'updates fee amount' do
              expect { validated }.to change {
                                        flight_offer.reload.price.fees[0].fee_amount.to_f
                                      }.to(response_data['price']['fees'][0]['amount'].to_f)
            end
          end

          describe 'updates traveler_pricing price' do
            before do
              flight_offer.traveler_pricings[0].update(traveler_internal_id: '1')
              flight_offer.traveler_pricings[1].update(traveler_internal_id: '2')
              flight_offer.traveler_pricings[2].update(traveler_internal_id: '3')

              flight_offer.reload.traveler_pricings[0].price.update(base_fare: 0.1, price_total: 0.1)
              flight_offer.reload.traveler_pricings[1].price.update(base_fare: 0.1, price_total: 0.1)
              flight_offer.reload.traveler_pricings[2].price.update(base_fare: 0.1, price_total: 0.1)
            end

            it 'updates price' do
              # Prone to be flaky
              expect { validated }.to change {
                                        flight_offer.reload.traveler_pricings[0].price.price_total.to_f
                                      }.to(response_data['travelerPricings'][0]['price']['total'].to_f)
            end

            it 'updates base' do
              # Prone to be flaky
              expect { validated }.to change {
                                        flight_offer.reload.traveler_pricings.find_by(traveler_internal_id: response_data['travelerPricings'][0]['travelerId']).price.base_fare.to_f
                                      }.to(response_data['travelerPricings'][0]['price']['base'].to_f)
            end

            it 'updates total' do
              expect { validated }.to change {
                                        flight_offer.reload.traveler_pricings.find_by(traveler_internal_id: response_data['travelerPricings'][0]['travelerId']).price.price_total.to_f
                                      }.to(response_data['travelerPricings'][0]['price']['total'].to_f)
            end

            it 'updates refundable taxes' do
              expect { validated }.to change {
                                        flight_offer.reload.traveler_pricings.find_by(traveler_internal_id: response_data['travelerPricings'][0]['travelerId']).price.refundable_taxes.to_f
                                      }.to(response_data['travelerPricings'][0]['price']['refundableTaxes'].to_f)
            end

            context 'updates traveler_pricing price taxes' do
              before do
                flight_offer.traveler_pricings[0].price.taxes[0].update(tax_code: 'EU')
                flight_offer.traveler_pricings[0].price.taxes[1].update(tax_code: 'IZ')
                flight_offer.traveler_pricings[0].price.taxes[2].update(tax_code: 'PT')

                flight_offer.traveler_pricings[1].price.taxes[0].update(tax_code: 'EU')
                flight_offer.traveler_pricings[1].price.taxes[1].update(tax_code: 'IZ')
                flight_offer.traveler_pricings[1].price.taxes[2].update(tax_code: 'PT')

                flight_offer.traveler_pricings[2].price.taxes[0].update(tax_code: 'EU')
                flight_offer.traveler_pricings[2].price.taxes[1].update(tax_code: 'IZ')
                flight_offer.traveler_pricings[2].price.taxes[2].update(tax_code: 'PT')

                flight_offer.reload.traveler_pricings[0].price.taxes[0].update(tax_amount: 0.1)
                flight_offer.reload.traveler_pricings[0].price.taxes[1].update(tax_amount: 0.1)
                flight_offer.reload.traveler_pricings[0].price.taxes[2].update(tax_amount: 0.1)

                flight_offer.reload.traveler_pricings[1].price.taxes[0].update(tax_amount: 0.1)
                flight_offer.reload.traveler_pricings[1].price.taxes[1].update(tax_amount: 0.1)
                flight_offer.reload.traveler_pricings[1].price.taxes[2].update(tax_amount: 0.1)

                flight_offer.reload.traveler_pricings[2].price.taxes[0].update(tax_amount: 0.1)
                flight_offer.reload.traveler_pricings[2].price.taxes[1].update(tax_amount: 0.1)
                flight_offer.reload.traveler_pricings[2].price.taxes[2].update(tax_amount: 0.1)
              end

              it 'updates tax amount' do
                expect { validated }.to change {
                                          flight_offer.reload.traveler_pricings[0].price.taxes.find_by(tax_code: response_data['travelerPricings'][0]['price']['taxes'][0]['code']).tax_amount.to_f
                                        }.to(response_data['travelerPricings'][0]['price']['taxes'][0]['amount'].to_f)
              end

              it 'creates non existent taxes' do
                validated

                expect(flight_offer.reload.traveler_pricings[0].price.taxes.size).to eq(response_data['travelerPricings'][0]['price']['taxes'].size)
              end
            end
          end
        end
      end

      describe 'errors' do
        context 'when flight_offer is expired' do
          before do
            flight_offer.update(last_ticketing_datetime: Time.now - 20)
          end

          it 'raises an error' do
            expect { validated }.to raise_error(FlightPricing::Validator::ExpiredOfferError)
          end
        end

        context 'when update data is invalid' do
          before do
            allow_any_instance_of(Price).to receive(:update).and_raise(ActiveRecord::RecordInvalid)
          end

          it 'raises an error' do
            expect { validated }.to raise_error(FlightPricing::Validator::Error)
          end
        end

        context 'when update data is not saved' do
          before do
            allow_any_instance_of(Price).to receive(:update).and_raise(ActiveRecord::RecordNotSaved)
          end

          it 'raises an error' do
            expect { validated }.to raise_error(FlightPricing::Validator::Error)
          end
        end

        # context 'when model to save does not exists' do
        #   before do
        #     allow_any_instance_of(Price).to receive(:find_or_initialize_by).and_raise(ActiveRecord::RecordNotFound)
        #   end

        #   it 'raises an error' do
        #     expect { validated }.to raise_error(FlightPricing::Validator::Error)
        #   end
        # end
      end
    end
  end
end
