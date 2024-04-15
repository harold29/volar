module FlightPricing
  class FeeSerializer < BaseSerializer
    attributes :amount,
               :type

    def amount
      object.fee_amount
    end

    def type
      object.fee_type
    end
  end
end
