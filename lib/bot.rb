require_relative "snow"
require "clockwork"

module Clockwork

  handler do |job, time|
    if job == "snow_parse.job"
      puts(Snow.process.key)
    end
  end

  every(30.minutes, 'snow_parse.job')
end
