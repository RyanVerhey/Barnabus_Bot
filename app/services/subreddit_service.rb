class SubredditService
  def self.update_subreddit(subreddit, channels = nil)
    channels ||= subreddit.channels
    channels = Array(channels)
    channels.each do |channel|
      puts "Updating videos for #{ channel }..."
      new_recents = new_recent_videos(channel: channel, subreddit: subreddit)

      channel.videos += new_recents
      channel.save

      new_recents.each do |vid|
        RedditPost.create(
          subreddit: subreddit,
          video: vid
        )
      end
    end
  end

  def self.post_new_videos(subreddit)
    new_vids = {}
    subreddit.channels.each do |channel|
      puts "Getting new vids for #{ channel }..."
      new_vids[channel.id] = new_videos(subreddit: subreddit, channel: channel)
    end

    reddit = Reddit.new(subreddit.account)
    reddit.login
    posted_successfully = {}
    new_vids.values.flatten.each do |vid|
      puts "Posting #{ vid }..."
      posted_successfully[vid.id] = reddit.submit_video video: vid, subreddit: subreddit
    end

    subreddit.channels.each do |channel|
      channel.videos += new_vids[channel.id]
      channel.save
    end

    new_vids.values.flatten.each do |vid|
      if posted_successfully[vid.id]
        RedditPost.create(
          subreddit: subreddit,
          video: vid
        )
      end
    end
  end

  def self.service_class_for_channel(channel)
    case channel
    when YoutubeChannel
      YouTube
    when TwitchChannel
      Twitch
    else
      VideoServiceBase
    end
  end

  def self.channel_for_channel_type(type)
    case type.downcase
    when 'youtube'
      YoutubeChannel
    when 'twitch'
      TwitchChannel
    end
  end

  def self.new_recent_videos(channel:, subreddit:)
    klass = service_class_for_channel(channel)
    klass.get_new_recent_videos(channel: channel, subreddit: subreddit)
  end

  def self.new_videos(channel:, subreddit:)
    self.new_recent_videos(channel: channel, subreddit: subreddit).reject do |v|
      RedditPost.find_by(subreddit: subreddit, video: v)
    end
  end
end
