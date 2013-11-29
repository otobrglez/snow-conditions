require_relative "snow"
require "clockwork"

module Clockwork
  handler do |job, time|
    puts "Running #{job} at #{time}"
  end

  every(5.seconds, 'parse_snow.job')
end
