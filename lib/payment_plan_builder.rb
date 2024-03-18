class PaymentPlanBuilder
  Error = Class.new(StandardError)

  def initialize(flight_finder_params)
    @flight_finder_params = flight_finder_params
  end

  def build
    with_errors_handler do
      flights = search_flights.flight_offers

      flights.map do |flight_offer|
        create_payment_plans(flight_offer)
      end.select(&:present?)
    end
  end

  private

  attr_accessor :offer_payment_plans, :flight_finder_params

  def create_payment_plans(flight_offer)
    payment_terms.map do |payment_term|
      flight_offer_departure_date = flight_offer.itineraries.first.segments.first.departure_at.to_date.to_s

      next unless payment_term.date_comply_with_payment_terms?(flight_offer_departure_date)

      create_payment_plan(flight_offer_departure_date,
                          flight_finder_params[:return_date],
                          flight_offer,
                          payment_term,
                          true)
    end.select(&:present?)
  end

  def create_payment_plan(departure_at, return_at, flight_offer, payment_term, active)
    PaymentPlan.create!(
      departure_at:,
      return_at:,
      flight_offer:,
      payment_term:,
      active:
    )
  end

  def with_errors_handler
    yield
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Validation failed: #{e.message}")
    raise Error, "Validation failed for a record: #{e.message}"
  rescue ActiveRecord::RecordNotSaved => e
    Rails.logger.error("Record not saved: #{e.message}")
    raise Error, "Record not saved: #{e.message}"
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error("Record not found: #{e.message}")
    raise Error, "Required record not found: #{e.message}"
  rescue StandardError => e
    Rails.logger.error("Error building payment plans: #{e.message}")
    raise Error, "Unhandled error: #{e.message}, backtrace: #{e.backtrace}"
  end

  def payment_terms
    @payment_terms ||= PaymentTerm.all.select(&:active?)
  end

  def search_flights
    FlightFinder.new(flight_finder_params).search_flights
  end
end
