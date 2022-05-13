# Include hook code here
require 'errors-rails'

begin
  # puts "-- Errors is active --"
rescue => e
  STDERR.puts "Problem starting Errors. Your app will run as normal."
  STDERR.puts e
end
