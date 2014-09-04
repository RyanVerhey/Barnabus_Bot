class YogscastKim
  include HTTParty

  def initialize
    data = YogscastKim.login
    @modhash = data[0]
    @cookie = data[1]
  end

  private

  def self.login
    username = 'Barnabus_Bot'
    password = ENV['PASS']
    options = { body: { user: username, passwd: password, api_type: 'json' } }
    response = YogscastKim.post("http://www.reddit.com/api/login/", options)
    puts [response['json']['data']['modhash'], response['json']['data']['cookie']]
    [response['json']['data']['modhash'], response['json']['data']['cookie']]
  end

  def to_s
    @modhash
  end

end
