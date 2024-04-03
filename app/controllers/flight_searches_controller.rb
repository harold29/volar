class FlightSearchesController < ApplicationController
  before_action :set_flight_search, only: %i[show]

  def index
    @flight_searches = FlightSearch.all
  end

  def show; end

  def create
    @flight_search = flight_finder.search_flights

    render :show, status: :created, location: @flight_search
  rescue FlightOffers::Finder::Error => e
    render json: e.message, status: :unprocessable_entity
  end

  private

  def set_flight_search
    @flight_search = FlightSearch.find(params[:id])
  end

  def flight_finder
    FlightOffers::Finder.new(current_user, flight_search_params)
  end

  def flight_search_params
    params.require(:flight_search).permit(:origin,
                                          :destination,
                                          :departure_date,
                                          :return_date,
                                          :one_way,
                                          :adults,
                                          :children,
                                          :infants,
                                          :travel_class,
                                          :currency_id,
                                          :nonstop)
  end
end
