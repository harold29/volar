class FlightSearchesController < ApplicationController
  before_action :set_flight_search, only: %i[show]

  def index
    @flight_searches = FlightSearch.all
  end

  def show; end

  def new
    @flight_search = FlightSearch.new
  end

  def create
    @flight_search = flight_finder.search_flights

    respond_to do |format|
      if @flight_search.errors.empty?
        format.html { redirect_to @flight_search, notice: 'Flight Search was successfully created.' }
        format.json { render :show, status: :created, location: @flight_search }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight_search.errors, status: :unprocessable_entity }
      end
    end
  rescue FlightFinder::Error => e
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: e.message, status: :unprocessable_entity }
    end
  end

  private

  def set_flight_search
    @flight_search = FlightSearch.find(params[:id])
  end

  def flight_finder
    current_user = User.last
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
