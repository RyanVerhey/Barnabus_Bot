class Reddit
  include HTTParty

  def self.submit_video(video)
    response = Reddit.submit title: video.title, message: video.url, subreddit: REDDITNAME.to_s
    if !response["json"]["errors"].first
      puts "Video posted: #{video.id}"
      puts "#{response["json"]["data"]["url"]}"
      return true
    else
      puts "Something went wrong. Response: #{response}"
      return false
    end
  end

  private

  def self.submit(params = {}) # title, message, sr, link = true, save = true, resubmit = false
    title =    params.fetch(:title, nil)
    message =  params.fetch(:message, nil)
    sr =       params.fetch(:subreddit, nil)
    link =     params.fetch(:link, true)
    save =     params.fetch(:save, true)
    resubmit = params.fetch(:resubmit, false)
    if title.nil? || message.nil? || sr.nil?
      raise "You need to have a post title, a message, and a subreddit defined!"
    else
      modhash, cookie = Reddit.login
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
        extension: 'json',
        uh: modhash,
      }, headers: {
        'User-Agent' => 'Barnabus_Bot, proudly built by /u/GildedGrizzly',
        'X-Modhash' => modhash,
        'Cookie' => 'reddit_session=' + cookie
      } }
      response = Reddit.post('https://ssl.reddit.com/api/submit', options)
    end
  end

  def self.login
    account_info = ReadWrite.fetch_reddit_account_info
    username = account_info[:username]
    password = ENV[account_info[:password_var]]
    options = { body: { user: username, passwd: password, api_type: 'json' } }
    options[:headers] = { 'User-Agent' => 'Barnabus_Bot, proudly built by /u/GildedGrizzly' }
    response = Reddit.post("https://ssl.reddit.com/api/login/", options)
    begin
      data = response['json']['data']
    rescue
      puts "Something went wrong logging into reddit. Here's the response:"
      p response
      raise "Error logging in to reddit"
    end
    return [data['modhash'], data['cookie']]
  end

end
