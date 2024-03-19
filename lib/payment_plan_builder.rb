class PaymentPlanBuilder
  Error = Class.new(StandardError)

  def self.build(current_user, flight_finder_params, flight_offers)
    new(current_user, flight_finder_params, flight_offers).build
  end

  def initialize(current_user, flight_finder_params, flight_offers)
    @current_user = current_user
    @flight_finder_params = flight_finder_params
    @flight_offers = flight_offers
  end

  def build
    with_errors_handler do
      flight_offers.map do |flight_offer|
        create_payment_plans(flight_offer)
      end.select(&:present?)
    end
  end

  private

  attr_accessor :flight_finder_params, :current_user, :flight_offers

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
end
