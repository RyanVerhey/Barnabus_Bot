class YogscastKim
  include HTTParty

  def initialize
    data = YogscastKim.login
    @modhash = data[0]
    @cookie = data[1]
  end

  def submit(title, message, sr, link = true, save = true, resubmit = false)
    kind = link ? "link" : "self"
    url = link ? message : false
    text = link ? false : message
    options = { body: {
      kind: kind,
      text: text,
      url: url,
      sr: sr,
      title: title,
      save: save,
      resubmit: resubmit,
      api_type: 'json',
      uh: @modhash,
    }, headers: {
      'User-Agent' => 'Barnabus_Bot, proudly built by /u/GildedGrizzly',
      'X-Modhash' => @modhash,
      'Cookie' => 'reddit_session=' + @cookie
    } }
    response = YogscastKim.post('http://www.reddit.com/api/submit', options)
  end

  private

  def self.login
    username = 'Barnabus_Bot'
    password = ENV['PASS']
    options = { body: { user: username, passwd: password, api_type: 'json' } }
    response = YogscastKim.post("http://www.reddit.com/api/login/", options)
    data = response['json']['data']
    return [data['modhash'], data['cookie']]
  end

  def to_s
    @modhash
  end

end
