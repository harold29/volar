class FlightSearchController < ApplicationController
  def index
    respond_to do |format|
      if @flight_search.save
        format.html { redirect_to carrier_url(@flight_search), notice: 'Flight Search was successfully created.' }
        format.json { render :show, status: :created, location: @flight_search }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight_search.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def flight_search
    @flight_search ||= flight_finder.search_flights
  end

  def flight_finder
    FlightFinder.new(flight_search_params)
  end

  def flight_search_params
    params.require(:flight_search).permit(:origin,
                                          :destination,
                                          :departure_date,
                                          :return_date,
                                          :passengers,
                                          :one_way,
                                          :adults,
                                          :children,
                                          :infants,
                                          :travel_class,
                                          :currency,
                                          :nonstop)
  end
end
