class CarriersController < ApplicationController
  before_action :set_carrier, only: %i[ show edit update destroy ]

  # GET /carriers or /carriers.json
  def index
    @carriers = Carrier.all
  end

  # GET /carriers/1 or /carriers/1.json
  def show
  end

  # GET /carriers/new
  def new
    @carrier = Carrier.new
  end

  # GET /carriers/1/edit
  def edit
  end

  # POST /carriers or /carriers.json
  def create
    @carrier = Carrier.new(carrier_params)

    respond_to do |format|
      if @carrier.save
        format.html { redirect_to carrier_url(@carrier), notice: "Carrier was successfully created." }
        format.json { render :show, status: :created, location: @carrier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carriers/1 or /carriers/1.json
  def update
    respond_to do |format|
      if @carrier.update(carrier_params)
        format.html { redirect_to carrier_url(@carrier), notice: "Carrier was successfully updated." }
        format.json { render :show, status: :ok, location: @carrier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carriers/1 or /carriers/1.json
  def destroy
    @carrier.destroy!

    respond_to do |format|
      format.html { redirect_to carriers_url, notice: "Carrier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier
      @carrier = Carrier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def carrier_params
      params.require(:carrier).permit(:name, :logo)
    end
end
