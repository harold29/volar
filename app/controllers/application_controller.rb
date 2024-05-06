# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # include RackSessionFixController

  def not_found!
    raise ActionController::RoutingError, 'Not Found'
  end
end
