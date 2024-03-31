class FlightSearchesController < ApplicationController
  before_action :set_flight_search, only: %i[show]

  def index
    @flight_searches = FlightSearch.all
  end

  def show; end

  def create
    @flight_search = flight_finder.search_flights
    if @flight_search.errors.empty?
      render :show, status: :created, location: @flight_search
    else
      render json: @flight_search.errors, status: :unprocessable_entity
    end
  rescue FlightFinder::Error => e
      render json: e.message, status: :unprocessable_entity
  end

  private

  def set_flight_search
    @flight_search = FlightSearch.find(params[:id])
  end

  def flight_finder
    FlightFinder.new(current_user, flight_search_params)
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
