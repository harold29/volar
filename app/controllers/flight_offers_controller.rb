class FlightOffersController < ApplicationController
  before_action :set_flight_offer, only: %i[ show edit update destroy ]

  # GET /flight_offers or /flight_offers.json
  def index
    @flight_offers = FlightOffer.all
  end

  # GET /flight_offers/1 or /flight_offers/1.json
  def show
  end

  # GET /flight_offers/new
  def new
    @flight_offer = FlightOffer.new
  end

  # GET /flight_offers/1/edit
  def edit
  end

  # POST /flight_offers or /flight_offers.json
  def create
    @flight_offer = FlightOffer.new(flight_offer_params)

    respond_to do |format|
      if @flight_offer.save
        format.html { redirect_to flight_offer_url(@flight_offer), notice: "Flight offer was successfully created." }
        format.json { render :show, status: :created, location: @flight_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flight_offers/1 or /flight_offers/1.json
  def update
    respond_to do |format|
      if @flight_offer.update(flight_offer_params)
        format.html { redirect_to flight_offer_url(@flight_offer), notice: "Flight offer was successfully updated." }
        format.json { render :show, status: :ok, location: @flight_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flight_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_offers/1 or /flight_offers/1.json
  def destroy
    @flight_offer.destroy!

    respond_to do |format|
      format.html { redirect_to flight_offers_url, notice: "Flight offer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight_offer
      @flight_offer = FlightOffer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_offer_params
      params.require(:flight_offer).permit(:internal_id, :source, :instant_ticketing_required, :non_homogeneous, :one_way, :last_ticketing_date, :number_of_bookable_seats, :price_total, :currency_id)
    end
end
