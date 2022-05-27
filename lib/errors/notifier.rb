# frozen_string_literal: true

module Errors
  class Notifier
    attr_accessor :exception, :enviroment

    def initialize(error, enviroment)
      @exception = error
      @enviroment = enviroment
    end

    def transmit
      uri = URI("http://#{Errors.configuration.host}/mop")
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end
      case res
      when Net::HTTPSuccess
        puts 'Sent Log to error server'
      else
        puts "Error sending log to error server : #{res.value}"
      end
    rescue Net::HTTPFatalError
      puts 'COULD NOT LOG ERROR WITH ERROR LOOGER!'
    rescue Errno::ECONNREFUSED
      puts 'COULD NOT FIND ERROR SERVER'
    end

    def output
      puts '-0-0-0-0-0-0-0-0-0-0-0-0-0-0 I caught an exception 0-0-0-0-0-0-0-0-0-0-0-0-0-0-'
      puts @exception.message
      puts '-0-0-0-0-0-0-0-0-0-0-0-0-0-0 I caught an exception 0-0-0-0-0-0-0-0-0-0-0-0-0-0-'
      puts @exception.backtrace
      puts '-0-0-0-0-0-0-0-0-0-0-0-0-0-0 I caught an exception 0-0-0-0-0-0-0-0-0-0-0-0-0-0-'
      puts @enviroment['REQUEST_URI']
      puts @enviroment['REQUEST_METHOD']
      puts @enviroment['REQUEST_PATH']
      puts relevant_lines.join("\n")
    end

    private

    def data
      {
        project: Errors.configuration.project_name,
        class_name: @exception.class.name,
        message: @exception.message,
        enviroment: 'development',
        request: @enviroment['REQUEST_URI'],
        method: @enviroment['REQUEST_METHOD'],
        path: @enviroment['REQUEST_PATH'],
        line_number: line_number,
        file_path: file,
        backtrace: traces,
        lines: relevant_lines
      }
    end

    def location
      @exception.backtrace_locations
    end

    def file
      return nil if location.blank?

      location.first.absolute_path
    end

    def line_number
      return nil if location.blank?

      location.first.lineno
    end

    def relevant_lines
      return [] if file.blank? || line_number.blank?

      lines = File.readlines(file)
      lines[(line_number - 2)..line_number + 10] || []
    end

    def traces
      bts = []
      @exception.backtrace.each do |b|
        bts << b
      end
      bts
    end
  end
end
