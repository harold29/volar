class FlightFinder
  Error = Class.new(StandardError)
  FlightRetrievingError = Class.new(Error)

  def initialize(current_user, flight_finder_params)
    @flight_finder_params = flight_finder_params
    @current_user = current_user
  end

  def search_flights
    with_error_handler do
      response = amadeus_client.shopping.flight_offers_search.get(request)

      flight_search = FlightSearch.new(flight_finder_params)
      flight_search.user = current_user

      flight_offers = FlightOfferParser.parse(response.data, flight_search)

      build_payment_plans(flight_offers)

      flight_search.flight_offers = flight_offers

      flight_search.save!

      flight_search
    end
  rescue Amadeus::ResponseError => e
    raise e
  end

  private

  attr_reader :flight_finder_params, :current_user

  def with_error_handler
    yield
  rescue Amadeus::ResponseError => e
    Rails.logger.error("Error retrieving flight offers: #{e.message}")
    raise FlightRetrievingError, "Error retrieving flight offers: #{e.message}"
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

  def request
    {
      originLocationCode: flight_finder_params[:origin],
      destinationLocationCode: flight_finder_params[:destination],
      departureDate: flight_finder_params[:departure_date],
      returnDate: flight_finder_params[:return_date],
      adults: flight_finder_params[:adults],
      children: flight_finder_params[:children],
      infants: flight_finder_params[:infants],
      travelClass: flight_finder_params[:travel_class],
      currencyCode: flight_finder_params[:currency],
      nonStop: flight_finder_params[:nonstop],
      oneWay: flight_finder_params[:one_way]
      # maxPrice: flight_finder_params[:max_price], # TODO: Add max price
      # max: flight_finder_params[:max] # TODO: Add max number of offers to return
      # includedAirlineCodes: flight_finder_params[:included_airline_codes], # TODO: Add included airline codes
      # excludedAirlineCodes: flight_finder_params[:excluded_airline_codes] # TODO: Add excluded airline codes
    }.reject { |_k, v| v.nil? }
  end

  def build_payment_plans(flight_offers)
    PaymentPlanBuilder.build(current_user, flight_finder_params, flight_offers)
  end

  def amadeus_client
    @client ||= Amadeus::Client.new(
      client_id: ENV['AMADEUS_CLIENT_ID'],
      client_secret: ENV['AMADEUS_CLIENT_SECRET']
    )
  end
end
