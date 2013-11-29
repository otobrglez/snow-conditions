require "spec_helper"

require "pushover"

describe Pushover do
  before do
    WebMock.stub_request(:post, "https://api.pushover.net/1/messages.json").
      with(:body => "token=#{ENV['PUSHOVER_KEY']}&user=#{ENV['PUSHOVER_USER']}&message=test").
      to_return lambda { |request| File.new("./spec/requests/pushover_post.html") }
  end

  it "should #post" do
    subject.push("test")["status"].should eq 1
  end
end
