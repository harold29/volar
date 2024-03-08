class FlightFinder
  def initialize(flight_finder_params)
    @flight_finder_params = flight_finder_params
  end

  def search_flights
    origin = @flight_finder_params[:origin]
    destination = @flight_finder_params[:destination]
    departure_date = @flight_finder_params[:departure_date]
    return_date = @flight_finder_params[:return_date]
    adults_travelers = @flight_finder_params[:adults]
    children = @flight_finder_params[:children]
    infants = @flight_finder_params[:infants]
    travel_class = @flight_finder_params[:travel_class]

    # byebug

    response = amadeus_client.shopping.flight_offers_search.get(originLocationCode: origin, destinationLocationCode: destination,
                                                                departureDate: departure_date, adults: adults_travelers)
    #   originLocationCode: origin,
    #   destinationLocationCode: destination,
    #   departureDate: departure_date,
    #   adults: return_date,
    #   adults,
    #   children,
    #   infants,
    #   travel_class
    # )
    # (
    #   originLocationCode: 'NYC', destinationLocationCode: 'MAD', departureDate: '2021-05-01', adults: 1
    # )
  end

  private

  def amadeus_client
    @client ||= Amadeus::Client.new(
      client_id: ENV['AMADEUS_CLIENT_ID'],
      client_secret: ENV['AMADEUS_CLIENT_SECRET']
    )
  end
end
