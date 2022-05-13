# frozen_string_literal: true

require 'errors/ror/version'
require 'errors/ror/railtie'  if defined?(Rails)

module Errors
  module Ror
    class Error < StandardError; end
    # Your code goes here...
  end
end
