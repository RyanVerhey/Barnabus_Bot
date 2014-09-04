class YogscastKim

  def initialize
    @modhash = YogscastKim.login
  end

  private

  def self.login
    username = 'Barnabus_Bot'
    password = ENV['PASS']
    options = { body: { user: username, passwd: password, api_type: 'json' } }
    response = HTTParty.post("http://www.reddit.com/api/login/", options)
    response['json']['data']['modhash']
  end

  def to_s
    @modhash
  end

end
