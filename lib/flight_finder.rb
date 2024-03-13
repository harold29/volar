class FlightFinder
  def initialize(flight_finder_params)
    @flight_finder_params = flight_finder_params
  end

  def search_flights
    response = amadeus_client.shopping.flight_offers_search.get(request)

    flight_search = FlightSearch.new(flight_finder_params)

    flight_offers = FlightOfferParser.parse(response.data)

    flight_search.flight_offers = flight_offers

    flight_search
  rescue Amadeus::ResponseError => e
    raise e
  end

  private

  attr_reader :flight_finder_params

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
      nonStop: flight_finder_params[:nonstop]
    }.reject { |_k, v| v.nil? }
  end

  def amadeus_client
    @client ||= Amadeus::Client.new(
      client_id: ENV['AMADEUS_CLIENT_ID'],
      client_secret: ENV['AMADEUS_CLIENT_SECRET']
    )
  end
end
