class Pushover
  include HTTParty
  base_uri 'https://api.pushover.net/1'

  def initialize params={}
    @params = params.merge!({
      token: ENV["PUSHOVER_KEY"],
      user: ENV["PUSHOVER_USER"]
    })
  end

  def push message, options={}
    self.class.post("/messages.json", body: @params.merge!({
      message: message
    }).merge!(options))
  end

end
