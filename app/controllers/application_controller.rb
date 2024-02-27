# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def not_found!
    raise ActionController::RoutingError, 'Not Found'
  end
end
