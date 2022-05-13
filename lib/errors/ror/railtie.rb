# frozen_string_literal: true

require 'rails'
require 'errors/ror/rack'

module Errors
  module Ror
    class Railtie < Rails::Railtie
      initializer 'errors-rails.middleware' do |app|
        app.config.middleware.insert_after ActionDispatch::DebugExceptions, Errors::Ror::Rack
      end
    end
  end
end
