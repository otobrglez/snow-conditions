require "spec_helper"

require "show"
require "pry"

describe Snow do

  it "should get status" do
    state = Snow.state

    # binding.pry

    puts state.date
    puts state.sha
  end


end

