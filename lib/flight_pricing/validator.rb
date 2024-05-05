module FlightPricing
  class Validator
    Error = Class.new(StandardError)
    ExpiredOfferError = Class.new(Error)

    def self.validate(flight_offers)
      new(flight_offers).validate
    end

    def initialize(flight_offers)
      @flight_offers = flight_offers
    end

    def validate
      raise ExpiredOfferError unless inside_ticketing_period?

      with_errors_handler do
        response = amadeus_client.post_flight_pricing(build_request_params)
        parsed_response = ResponseParser.parse(response.data, flight_offers)

        update_flight_offers(parsed_response)
      end
    end

    private

    attr_reader :flight_offers

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

    def update_flight_offers(response)
      # Update fees
      flight_offers.each_with_index do |flight_offer, index|
        fee_attributes = response[index][:price_attributes].delete(:fees_attributes)

        fee_attributes.each do |fee_attribute|
          fee = flight_offer.price.fees.find_or_initialize_by(fee_type: fee_attribute[:fee_type], price_id: flight_offer.price.id)
          fee.update(fee_attribute)
        end

        # Update flight_offer.price
        flight_offer.price.update(response[index][:price_attributes])

        # Update traveler_pricing, price and taxes
        response[index][:traveler_pricings_attributes].each do |response_traveler_pricing|
          # Get traveler_pricing by traveler_internal_id and flight_offer_id
          traveler_pricing = flight_offer.traveler_pricings.find_or_initialize_by(
            traveler_internal_id: response_traveler_pricing[:traveler_internal_id], flight_offer_id: flight_offer.id
          )

          # Get taxes attributes and remove them from price_attributes
          taxes_attributes = response_traveler_pricing[:price_attributes].delete(:taxes_attributes)

          next if traveler_pricing.new_record?

          # Update taxes
          taxes_attributes.each do |tax_attributes|
            traveler_pricing.price.taxes.find_or_initialize_by(tax_code: tax_attributes[:tax_code],
                                                               price_id: traveler_pricing.price.id).update(tax_attributes)
          end

          # Update traveler pricing price
          traveler_pricing.price.update(response_traveler_pricing[:price_attributes])
        end
      end
    end

    def inside_ticketing_period?
      # flight_offer.first.last_ticketing_datetime > Time.now # TODO: one single flight offer?
      flight_offers.map { |offer| offer.last_ticketing_datetime > Time.now }.all?
    end

    def build_request_params
      RequestBuilder.new(flight_offers).build_request
    end

    def amadeus_client
      @amadeus_client ||= Amadeus::Client.new
    end
  end
end
