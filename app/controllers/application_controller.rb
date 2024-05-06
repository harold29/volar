# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include RackSessionFixController
  include ActionController::MimeResponds

  def not_found!
    raise ActionController::RoutingError, 'Not Found'
  end
end
