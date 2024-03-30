class FlightOfferParser # rubocop:disable Metrics/ClassLength
  Error = Class.new(StandardError)

  def self.parse(response, flight_search)
    new(response, flight_search).parse
  end

  attr_reader :response

  def initialize(response, flight_search)
    @response = deep_snake_case_keys(response)
    @flight_search = flight_search
  end

  def parse
    with_errors_handler do
      parse_offer_params
    end
  end

  private

  attr_accessor :flight_search

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

  %i[itineraries segments stops traveler_pricings fees fare_details_by_segments amenities additional_services].each do |key|
    define_method("parse_#{key}") do |fields_data|
      return {} if fields_data.nil?

      fields_data.map do |data|
        send("#{key}_params", data)
      end
    end
  end

  %i[airport currency carrier].each do |key|
    define_method("#{key}") do |code|
      variable_name = "@#{key}"
      object = instance_variable_get(variable_name)

      search_attribute = key == :airport ? :iata_code : :code

      return object if object.present? && object.send(search_attribute) == code

      object = key.to_s.capitalize.constantize.find_by(search_attribute => code)
      instance_variable_set(variable_name, object)
    end
  end

  def parse_offer_params
    response.map do |flight_offer_data|
      FlightOffer.create!(flight_offer_params(flight_offer_data))
    end
  end

  def flight_offer_params(flight_offer_data)
    {
      internal_id: flight_offer_data[:id].to_s,
      source: flight_offer_data[:source],
      instant_ticketing_required: flight_offer_data[:instant_ticketing_required],
      non_homogeneous: flight_offer_data[:non_homogeneous],
      one_way: flight_offer_data[:one_way],
      last_ticketing_date: flight_offer_data[:last_ticketing_date],
      last_ticketing_datetime: flight_offer_data[:last_ticketing_date_time],
      number_of_bookable_seats: flight_offer_data[:number_of_bookable_seats],
      price_total: flight_offer_data[:price][:total],
      payment_card_required: flight_offer_data[:price][:payment_card_required] || false,
      currency: currency(flight_offer_data[:price][:currency]),
      itineraries_attributes: parse_itineraries(flight_offer_data[:itineraries]),
      price_attributes: parse_price(flight_offer_data[:price]),
      traveler_pricings_attributes: parse_traveler_pricings(flight_offer_data[:traveler_pricings]),
      flight_search:
    }
  end

  def itineraries_params(itinerary_data)
    {
      duration: itinerary_data[:duration],
      segments_attributes: parse_segments(itinerary_data[:segments])
    }
  end

  def segments_params(segment_data)
    {
      departure_airport: airport(segment_data[:departure][:iata_code]),
      arrival_airport: airport(segment_data[:arrival][:iata_code]),
      departure_at: segment_data[:departure][:at],
      arrival_at: segment_data[:arrival][:at],
      carrier: carrier(segment_data[:carrier_code]),
      flight_number: segment_data[:number],
      aircraft_code: segment_data[:aircraft][:code],
      duration: segment_data[:duration],
      stops_number: segment_data[:number_of_stops],
      blacklisted_in_eu: segment_data[:blacklisted_in_eu],
      stops_attributes: parse_stops(segment_data[:stops]),
      internal_id: segment_data[:id].to_s
    }
  end

  def stops_params(stop_data)
    {
      airport: airport(stop_data[:iata_code]),
      duration: stop_data[:duration],
      arrival_at: stop_data[:arrival_at],
      departure_at: stop_data[:departure_at]
    }
  end

  def parse_price(price_data)
    {
      price_total: price_data[:total],
      price_grand_total: price_data[:grand_total],
      price_currency: currency(price_data[:currency]),
      billing_currency: currency(price_data[:currency]),
      base_fare: price_data[:base],
      refundable_taxes: price_data[:refundable_taxes],
      fees_attributes: parse_fees(price_data[:fees]),
      additional_services_attributes: parse_additional_services(price_data[:additional_services])
    }
  end

  def fees_params(fee_data)
    {
      fee_amount: fee_data[:amount],
      fee_type: fee_data[:type],
      fee_description: fee_data[:description] # Not defined yet
    }
  end

  def traveler_pricings_params(traveler_pricing_data)
    {
      fare_option: traveler_pricing_data[:fare_option],
      traveler_type: traveler_pricing_data[:traveler_type],
      price_total: traveler_pricing_data[:price][:total],
      price_base: traveler_pricing_data[:price][:base],
      traveler_internal_id: traveler_pricing_data[:traveler_id],
      price_currency: currency(traveler_pricing_data[:price][:currency]),
      fare_details_by_segments_attributes: parse_fare_details_by_segments(traveler_pricing_data[:fare_details_by_segment])
    }
  end

  def fare_details_by_segments_params(fare_detail_by_segment_data)
    {
      segment_internal_id: fare_detail_by_segment_data[:segment_id],
      cabin: fare_detail_by_segment_data[:cabin],
      fare_basis: fare_detail_by_segment_data[:fare_basis],
      included_checked_bags: fare_detail_by_segment_data[:included_checked_bags][:quantity],
      branded_fare: fare_detail_by_segment_data[:branded_fare],
      branded_fare_label: fare_detail_by_segment_data[:branded_fare_label],
      flight_class: fare_detail_by_segment_data[:class],
      amenities_attributes: parse_amenities(fare_detail_by_segment_data[:amenities])
    }
  end

  def amenities_params(amenity_data)
    {
      description: amenity_data[:description],
      is_chargeable: amenity_data[:is_chargeable],
      amenity_type: amenity_data[:amenity_type],
      amenity_provider_name: amenity_data[:amenity_provider][:name]
    }
  end

  def additional_services_params(additional_services_data)
    {
      service_type: additional_services_data[:type],
      service_amount: additional_services_data[:amount]
    }
  end
end
