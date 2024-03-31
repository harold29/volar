class FlightOffersController < ApplicationController
  before_action :set_flight_offer, only: %i[show update destroy]

  # GET /flight_offers or /flight_offers.json
  def index
    @flight_offers = FlightOffer.all
  end

  # GET /flight_offers/1 or /flight_offers/1.json
  def show; end

  # POST /flight_offers or /flight_offers.json
  def create
    @flight_offer = FlightOffer.new(flight_offer_params)

    if @flight_offer.save
      render :show, status: :created, location: @flight_offer
    else
      render json: @flight_offer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /flight_offers/1 or /flight_offers/1.json
  def update
    if @flight_offer.update(flight_offer_params)
      render :show, status: :ok, location: @flight_offer
    else
      render json: @flight_offer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /flight_offers/1 or /flight_offers/1.json
  def destroy
    @flight_offer.destroy!

    render json: { message: 'Flight offer was successfully destroyed.' }, head: :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_flight_offer
    @flight_offer = FlightOffer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def flight_offer_params
    params.require(:flight_offer).permit(:internal_id, :source,
                                         :instant_ticketing_required, :non_homogeneous,
                                         :one_way, :last_ticketing_date, :last_ticketing_datetime,
                                         :number_of_bookable_seats, :price_total, :currency_id, :flight_search_id)
  end
end
