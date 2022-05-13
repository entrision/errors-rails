# frozen_string_literal: true

require 'errors/rails/version'
require 'errors/rails/railtie' if defined?(Rails::Railtie)

module Errors
  module Rails
    class Error < StandardError; end
    # Your code goes here...
  end
end
