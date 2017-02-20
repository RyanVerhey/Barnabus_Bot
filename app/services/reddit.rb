class Reddit
  include HTTParty

  def initialize(reddit_account)
    @account = reddit_account
  end

  def login
    options = { body: { user: @account.username, passwd: @account.password, api_type: 'json' } }
    options[:headers] = { 'User-Agent' => 'Barnabus_Bot, proudly built by /u/GildedGrizzly' }
    response = Reddit.post("https://ssl.reddit.com/api/login/", options)
    begin
      data = response['json']['data']
    rescue
      puts "Something went wrong logging into reddit. Here's the response:"
      p response
      raise "Error logging in to reddit"
    end

    @modhash = data['modhash']
    @cookie = data['cookie']
  end

  def submit_video(video:, subreddit:)
    response = submit title: video.title, message: video.url, subreddit: subreddit
    if !response["json"]["errors"].first
      puts "Video posted: #{ video }"
      puts "#{response["json"]["data"]["url"]}"
      return true
    elsif response["json"]["errors"].first && response["json"]["errors"].first.try(:first) == "ALREADY_SUB"
      puts "Video #{video.id} (#{video.title}) from #{video.author} has already been posted to #{subreddit}"
      return false
    else
      puts "Something went wrong. Response: #{response}"
      return false
    end
  end

  private

  def submit(title:nil, message:nil, subreddit:nil, link:true, save:true, resubmit:false)
    if title.nil? || message.nil? || subreddit.nil?
      raise "You need to have a post title, a message, and a subreddit defined!"
    else
      kind = link ? "link" : "self"
      url = link ? message : false
      text = link ? false : message
      options = { body: {
        kind: kind,
        text: text,
        url: url,
        sr: subreddit.to_s,
        title: title,
        save: save,
        resubmit: resubmit,
        api_type: 'json',
        extension: 'json',
        uh: @modhash,
      }, headers: {
        'User-Agent' => 'Barnabus_Bot, proudly built by /u/GildedGrizzly',
        'X-Modhash' => @modhash,
        'Cookie' => 'reddit_session=' + @cookie
      } }
      response = Reddit.post('https://ssl.reddit.com/api/submit', options)
    end
  end

end
