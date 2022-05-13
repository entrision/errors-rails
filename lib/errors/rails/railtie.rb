# frozen_string_literal: true

require 'rails'

module Errors
  module Rails
    class ErrorsRailsRailtie < Rails::Railtie
      initializer 'errors-rails.middleware' do |app|
        # use app.config.middleware.insert_after to ignore local exceptions
        app.config.middleware.insert_before ActionDispatch::DebugExceptions, Errors::Rails::Rack
      end
    end
  end
end
