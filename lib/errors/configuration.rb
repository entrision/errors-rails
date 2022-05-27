module Errors
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

    alias_method :config, :configuration
  end

  class Configuration
    attr_accessor :host
    attr_accessor :project_name

    def initialize
      @host = '159.223.206.206'.freeze unless Rails.env.development?
      @host = '127.0.0.1:3001'.freeze if Rails.env.development?
      @project_name = Rails.application.class.module_parent_name
    end
  end
end
