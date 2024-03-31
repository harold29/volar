class PaymentTermsController < ApplicationController
  before_action :set_payment_term, only: %i[show update destroy]

  # GET /payment_terms or /payment_terms.json
  def index
    @payment_terms = PaymentTerm.all
  end

  # GET /payment_terms/1 or /payment_terms/1.json
  def show; end

  # POST /payment_terms or /payment_terms.json
  def create
    @payment_term = PaymentTerm.new(payment_term_params)

    if @payment_term.save
      render :show, status: :created, location: @payment_term
    else
      render json: @payment_term.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_terms/1 or /payment_terms/1.json
  def update
    if @payment_term.update(payment_term_params)
      render :show, status: :ok, location: @payment_term
    else
      render json: @payment_term.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payment_terms/1 or /payment_terms/1.json
  def destroy
    @payment_term.destroy!

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment_term
    @payment_term = PaymentTerm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_term_params
    params.require(:payment_term).permit(:name,
                                         :description,
                                         :payment_type,
                                         :payment_terms,
                                         :payment_terms_description,
                                         :payment_terms_conditions,
                                         :payment_terms_conditions_url,
                                         :payment_terms_file,
                                         :payment_terms_file_url,
                                         :days_max_number,
                                         :days_min_number,
                                         :payment_period_in_days,
                                         :interest_rate,
                                         :penalty_rate,
                                         :installments_max_number,
                                         :installments_min_number,
                                         :installments,
                                         :active,
                                         :deleted)
  end
end
