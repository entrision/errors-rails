module Errors
  module Rails
    class Rack
      def initialize(app)
        @app = app
        raise 's'
      end

      def call(env)
        begin
          response = @app.call(env)
        rescue Exception => exception
          puts '-0-0-0-0-0-0-0-0-0-0-0-0-0-0 I caught an exception 0-0-0-0-0-0-0-0-0-0-0-0-0-0-'

          raise
        end

        response
      end
    end
  end
end
