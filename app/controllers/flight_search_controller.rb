class FlightSearchController < ApplicationController

  def search
    @flight_finder.search_flights
  end

  private

  def flight_finder
    @flight_finder ||= FlightFinder.new(flight_search_params)
  end

  def flight_search_params
    params.require(:flight_search).permit(:origin, :destination, :departure_date, :return_date, :passengers, :one_way, :adults, :children, :infants, :travel_class)
  end
end
