module Amadeus
  class Errors < StandardError
    attr_reader :response, :response_body, :status_code

    def initialize(response)
      @response = response
      @response_body = JSON.parse(response&.body) if response.respond_to?(:body) && response&.body
      @status_code = response&.status if response.respond_to?(:status) && response&.status

      super(description)
    rescue JSON::ParserError
      @response_body = response&.body
    end

    def message
      JSON.parse(@response&.body) if @response.respond_to?(:body) && @response&.body
    rescue JSON::ParserError
      if @response.respond_to?(:body) && @response&.body
        @response&.body
      else
        @response
      end
    end

    def description
      description = ''

      if response.respond_to?(:body) && response&.body
        description = short_description
        description += long_description
      end

      description
    end

    def short_description
      if response.respond_to?(:status) && response.status
        "[#{response.status}]"
      else
        '[---]'
      end
    end

    def long_description
      message = ''
      if response
        message += error_description if response_body['error_description']
        message += errors_description if response_body['errors']
      end

      message
    end

    def error_description
      message = ''
      message += "\n#{response_body['error']}" if response_body['error']
      message += "\n#{response_body['error_description']}"
      message
    end

    def errors_description
      response_body['errors'].map do |error|
        message = "\n"
        message += "[#{error['source']['parameter']}] " if error['source'] && error['source']['parameter']
        message + error['detail'] if error['detail']
      end.join
    end
  end

  class ResponseError < Errors; end
  class RequestError < Errors; end
  class ServerError < Errors; end
  class ClientError < Errors; end
  class AuthenticationError < Errors; end
  class ForbiddenError < Errors; end
  class NotFoundError < Errors; end
  class RateLimitError < Errors; end
  class InternalServerError < Errors; end
  class ServiceUnavailableError < Errors; end
  class GatewayTimeoutError < Errors; end
  class BadGatewayError < Errors; end
  class UnknownError < Errors; end
end
