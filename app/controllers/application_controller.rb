# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  include RackSessionFixController

  def not_found!
    raise ActionController::RoutingError, 'Not Found'
  end
end
