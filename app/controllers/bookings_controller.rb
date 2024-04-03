class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render :show, status: :created, location: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(
      :booking_datetime,
      :booking_status,
      :booking_amount,
      :booking_currency_id,
      :booking_confirmed,
      :booking_confirmation_datetime,
      :booking_confirmation_number,
      :payment_type,
      :payment_plan_id,
      :total_installments,
      :installments_amount,
      :payments_completed
    )
  end
end
