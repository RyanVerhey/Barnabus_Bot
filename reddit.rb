class Reddit
  include HTTParty

  def self.submit_video(video)
    puts 'Video!'
    response = Reddit.submit title: video.title, message: video.url, subreddit: REDDITNAME.to_s
    if !response["json"]["errors"].first
      puts "Video posted! #{response["json"]["data"]["url"]}"
      return true
    else
      puts "Something went wrong. Response: #{response}"
      return false
    end
  end

  private

  def self.submit(title, message, sr, link = true, save = true, resubmit = false)
    data = Reddit.login
    modhash = data[0]
    cookie = data[1]
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
      uh: modhash,
    }, headers: {
      'User-Agent' => 'Barnabus_Bot, proudly built by /u/GildedGrizzly',
      'X-Modhash' => modhash,
      'Cookie' => 'reddit_session=' + cookie
    } }
    response = Reddit.post('http://www.reddit.com/api/submit', options)
  end

  def self.login
    username = 'Barnabus_Bot'
    password = ENV['PASS']
    options = { body: { user: username, passwd: password, api_type: 'json' } }
    response = Reddit.post("http://www.reddit.com/api/login/", options)
    data = response['json']['data']
    return [data['modhash'], data['cookie']]
  end

end
