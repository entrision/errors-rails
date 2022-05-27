# frozen_string_literal: true

module Errors
  module Ror
    class Rack
      require 'uri'
      require 'net/http'



      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          response = @app.call(env)
        rescue Exception => e
          notifier = ::Errors::Notifier.new(e, env)
          notifier.transmit
          notifier.output
          raise
        end

        response
      end
    end
  end
end
