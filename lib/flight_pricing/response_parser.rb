module FlightPricing
  class ResponseParser
    def self.parse(response, flight_offer)
      new(response, flight_offer).parse
    end

    def initialize(response, flight_offer)
      @response = deep_snake_case_keys(response)
      @flight_offer = flight_offer
    end

    def parse
      with_errors_handler do
        flight_pricing_response.map do |response|
          deep_compact(response)
        end
      end
    end

    private

    attr_reader :response, :flight_offer

    include Utils

    def with_errors_handler
      yield
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Validation failed: #{e.message}")
      raise Error, "Validation failed for a record: #{e.message}"
    rescue ActiveRecord::RecordNotSaved => e
      Rails.logger.error("Record not saved: #{e.message}")
      raise Error, "Record not saved: #{e.message}"
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("Record not found: #{e.message}")
      raise Error, "Required record not found: #{e.message}"
    rescue StandardError => e
      Rails.logger.error("Error building payment plans: #{e.message}")
      raise Error, "Unhandled error: #{e.message}, backtrace: #{e.backtrace}"
    end

    def flight_pricing_response
      response[:flight_offers].map do |flight_offer|
        {
          internal_id: flight_offer[:id].to_s,
          source: flight_offer[:source],
          instant_ticketing_required: flight_offer[:instant_ticketing_required],
          non_homogeneous: flight_offer[:non_homogeneous],
          one_way: flight_offer[:one_way],
          last_ticketing_date: flight_offer[:last_ticketing_date],
          last_ticketing_datetime: flight_offer[:last_ticketing_date_time],
          number_of_bookable_seats: flight_offer[:number_of_bookable_seats],
          pricing_options_fare_type: flight_offer[:pricing_options][:fare_type],
          pricing_options_included_checked_bags_only: flight_offer[:pricing_options][:included_checked_bags_only],
          pricing_options_refundable_fare: flight_offer[:pricing_options][:refundable_fare],
          pricing_options_no_restriction_fare: flight_offer[:pricing_options][:no_restriction_fare],
          pricing_options_no_penalty_fare: flight_offer[:pricing_options][:no_penalty_fare],
          validating_airline_codes: flight_offer[:validating_airline_codes],
          price_total: flight_offer[:price][:total],
          payment_card_required: flight_offer[:price][:payment_card_required] || false,
          currency: currency(flight_offer[:price][:currency]),
          itineraries_attributes: parse_itineraries(flight_offer[:itineraries]),
          price_attributes: parse_price(flight_offer[:price]),
          traveler_pricings_attributes: parse_traveler_pricings(flight_offer[:traveler_pricings])
        }
      end
    end

    def parse_itineraries(itineraries)
      return [] if itineraries.blank?

      itineraries.map do |itinerary|
        {
          duration: itinerary[:duration],
          segments_attributes: parse_segments(itinerary[:segments])
        }
      end
    end

    def parse_segments(segments)
      return [] if segments.blank?

      segments.map do |segment|
        {
          departure_airport: airport(segment[:departure][:iata_code]),
          arrival_airport: airport(segment[:arrival][:iata_code]),
          departure_at: segment[:departure][:at],
          arrival_at: segment[:arrival][:at],
          carrier: carrier(segment[:carrier_code]),
          flight_number: segment[:number],
          aircraft_code: segment[:aircraft][:code],
          duration: segment[:duration],
          stops_number: segment[:number_of_stops],
          blacklisted_in_eu: segment[:blacklisted_in_eu],
          stops_attributes: parse_stops(segment[:stops]),
          internal_id: segment[:id].to_s
        }
      end
    end

    def parse_stops(stops)
      return [] if stops.blank?

      stops.map do |stop|
        {
          airport: airport(stop[:iata_code]),
          duration: stop[:duration]
        }
      end
    end

    def parse_price(price)
      {
        currency: currency(price[:currency]),
        price_total: price[:total],
        base_fare: price[:base],
        price_grand_total: price[:grand_total],
        fees_attributes: parse_fees(price[:fees]),
        taxes_attributes: parse_taxes(price[:taxes]),
        refundable_taxes: price[:refundable_taxes]
      }
    end

    def parse_fees(fees)
      return [] if fees.blank?

      fees.map do |fee|
        {
          amount: fee[:amount],
          type: fee[:type]
        }
      end
    end

    def parse_taxes(taxes)
      return [] if taxes.blank?

      taxes.map do |tax|
        {
          tax_code: tax[:code],
          tax_amount: tax[:amount]
        }
      end
    end

    def parse_traveler_pricings(traveler_pricings)
      return [] if traveler_pricings.blank?

      traveler_pricings.map do |traveler_pricing|
        {
          traveler_internal_id: traveler_pricing[:traveler_id],
          fare_option: traveler_pricing[:fare_option],
          traveler_type: traveler_pricing[:traveler_type],
          price_attributes: parse_price(traveler_pricing[:price]),
          fare_details_by_segments_attributes: parse_fare_details_by_segment(traveler_pricing[:fare_details_by_segment])
        }
      end
    end

    def parse_fare_details_by_segment(fare_details_by_segments)
      return [] if fare_details_by_segments.blank?

      fare_details_by_segments.map do |fare_detail_by_segment|
        {
          segment_internal_id: fare_detail_by_segment[:segment_id],
          cabin: fare_detail_by_segment[:cabin],
          fare_basis: fare_detail_by_segment[:fare_basis],
          branded_fare: fare_detail_by_segment[:branded_fare],
          flight_class: fare_detail_by_segment[:class],
          included_checked_bags: fare_detail_by_segment[:included_checked_bags][:quantity]
        }
      end
    end
  end
end
