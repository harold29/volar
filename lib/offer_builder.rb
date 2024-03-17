class OfferBuilder
  def initialize(flight_finder_params)
    @flight_finder_params = flight_finder_params
  end

  def build
    departure_date = flight_finder_params[:departure_date]

    flights = search_flights.flight_offers

    offer_payment_plans = base_offer

    flights.each do |flight_offer|
      payment_plans.each do |payment_plan|
        flight_offer_departure_date = flight_offer.itineraries.first.segments.first.departure_at.to_date.to_s

        break unless payment_plan.date_comply_with_payment_terms?(flight_offer_departure_date)

        number_of_installments = payment_plan.number_of_installments_from_date(flight_offer_departure_date)
        installment_amounts = payment_plan.calculate_installment_amounts(flight_offer.price_total, flight_offer_departure_date)

        offer = {
          payment_plan: payment_plan.name,
          departure_date:,
          return_date: flight_finder_params[:return_date],
          installments_number: number_of_installments,
          installment_amounts:,
          flight_offer:
        }

        offer_payment_plans[:payment_plans] << offer
      end
    end

    offer_payment_plans
  end

  private

  attr_accessor :offer_payment_plans, :flight_finder_params

  def base_offer
    {
      # payment_plan: payment_plan.name,
      departure_date: flight_finder_params[:departure_date],
      return_date: flight_finder_params[:return_date],
      adults: flight_finder_params[:adults],
      children: flight_finder_params[:children],
      infants: flight_finder_params[:infants],
      travel_class: flight_finder_params[:travel_class],
      currency: flight_finder_params[:currency],
      one_way: flight_finder_params[:one_way],
      payment_plans: []
    }
  end

  def payment_plans
    @payment_plans ||= PaymentPlan.all.select(&:active?)
  end

  def search_flights
    FlightFinder.new(flight_finder_params).search_flights
  end
end
