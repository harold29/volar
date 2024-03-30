module Amadeus
  class Client
    AMADEUS_HOST = ENV['AMADEUS_HOST'] || 'https://test.api.amadeus.com'
    AMADEUS_FLIGHT_OFFER_PATH = '/v2/shopping/flight-offers'
    AMADEUS_CONFIRM_FLIGHT_OFFER_PATH = '/v1/booking/flight-orders'

    def get_flight_offers(params)
      error_handler do
        response = connection.get(AMADEUS_FLIGHT_OFFER_PATH) do |req|
          req.params = RequestParamsSerializer.serialize(params)
        end

        handle_response(response)
      end
    end

    def post_flight_offers(params)
      error_handler do
        response = connection.post(AMADEUS_FLIGHT_OFFER_PATH) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = RequestParamsSerializer.serialize(params).to_json
        end

        handle_response(response)
      end
    end

    def post_confirm_price_and_availability(params)
      error_handler do
        connection.post(AMADEUS_CONFIRM_FLIGHT_OFFER_PATH) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = params.to_json
        end
      end
    end

    private

    def handle_response(response)
      raise Amadeus::ResponseError, response if response.nil? || response.body.nil?

      case response.status
      when 200
        Response.new(response)
      when 400
        raise Amadeus::RequestError, response
      when 401
        raise Amadeus::RequestError, response
      when 403
        raise Amadeus::RequestError, response
      when 404
        raise Amadeus::RequestError, response
      when 500
        raise Amadeus::ServerError, response
      else
        raise Amadeus::UnknownError, response
      end
    end

    def error_handler(&block)
      yield
    rescue JSON::ParserError => e
      raise Amadeus::ResponseError, 'Invalid JSON response'
    rescue Amadeus::Errors => e
      raise e
    end

    def connection
      @connection ||= Faraday.new(url: AMADEUS_HOST) do |faraday|
        faraday.request :authorization, 'Bearer', AccessToken.instance.bearer_token
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
