class CarriersController < ApplicationController
  before_action :set_carrier, only: %i[show update destroy]

  # GET /carriers or /carriers.json
  def index
    @carriers = Carrier.all
  end

  # GET /carriers/1 or /carriers/1.json
  def show; end

  # POST /carriers or /carriers.json
  def create
    @carrier = Carrier.new(carrier_params)

    if @carrier.save
      render :show, status: :created, location: @carrier
    else
      render json: @carrier.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carriers/1 or /carriers/1.json
  def update
    if @carrier.update(carrier_params)
      render :show, status: :ok, location: @carrier
    else
      render json: @carrier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carriers/1 or /carriers/1.json
  def destroy
    @carrier.destroy!

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def carrier_params
    params.require(:carrier).permit(:name, :logo, :code)
  end
end
