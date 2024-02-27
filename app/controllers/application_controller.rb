class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def not_found!
    raise ActionController::RoutingError.new("Not Found")
  end
end
