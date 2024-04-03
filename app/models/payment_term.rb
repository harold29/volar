class PaymentTerm < ApplicationRecord
  validates :name,
            :payment_type,
            :description,
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
            :installments_min_number, presence: true

  validates :active, :installments, :deleted, inclusion: { in: [true, false] }

  validates :interest_rate, :penalty_rate,
            numericality: {
              greater_than_or_equal_to: 0
            }

  validates :days_max_number,
            :days_min_number,
            :payment_period_in_days,
            :installments_max_number,
            :installments_min_number,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  def date_comply_with_payment_terms?(date)
    days_until_last_installment = days_until_last_installment(date)

    return false if days_until_last_installment.negative?

    days_until_last_installment <= days_max_number &&
      days_until_last_installment >= days_min_number &&
      matches_installments?(days_until_last_installment)
  end

  def number_of_installments_from_date(date)
    days_until_last_installment = days_until_last_installment(date)

    return 0 if days_until_last_installment.negative? || !date_comply_with_payment_terms?(date)

    number_of_installments(days_until_last_installment)
  end

  def calculate_installments_amounts(amount, date)
    amount = amount.to_d
    installments_amounts = []
    increased_amount = amount * (1 + interest_rate.to_d)
    num_installments = number_of_installments(days_until_last_installment(date))

    base_installment_amount = (increased_amount / num_installments).to_d

    num_installments.to_i.times do |_i|
      installment_amount = base_installment_amount

      installments_amounts << installment_amount
    end

    adjust_installments(installments_amounts)
  end

  private

  def days_until_last_installment(date)
    date = date.to_date
    today = Time.now.to_date

    (date - today).to_i
  end

  def matches_installments?(number_of_days)
    num_installments = number_of_installments(number_of_days)

    num_installments >= installments_min_number &&
      num_installments <= installments_max_number
  end

  def number_of_installments(number_of_days)
    num_installments = number_of_days / payment_period_in_days

    return installments_max_number if num_installments >= installments_max_number

    num_installments
  end

  def adjust_installments(installments_amounts)
    return installments_amounts if installments_amounts.sum.zero? || installments_amounts.sum.negative? || installments_amounts.size.zero?

    installments_amounts.map!(&:to_d)

    rounded_installments = installments_amounts.map(&:floor)

    total_difference = installments_amounts.sum - rounded_installments.sum

    rounded_installments[-1] += total_difference
    rounded_installments[-1] = rounded_installments[-1].ceil

    rounded_installments.map!(&:to_d)
  end
end
