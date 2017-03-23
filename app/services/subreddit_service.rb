class SubredditService
  def self.update_subreddit(subreddit, channels = nil)
    channels ||= subreddit.channels
    channels = Array(channels)
    channels.each do |channel|
      LOGGER.info "Updating videos for #{ channel }..."
      new_recents = new_recent_videos(channel: channel, subreddit: subreddit)

      channel.videos += new_recents
      channel.save

      new_recents.each do |vid|
        rp = RedditPost.new(
          subreddit: subreddit,
          video: vid
        )
        rp.save
      end
      LOGGER.info "Finished updating videos for #{subreddit}"
      LOGGER.info ""
    end
  end

  def self.post_new_videos(subreddit)
    new_vids = {}
    subreddit.channels.each do |channel|
      LOGGER.info "Getting new vids for #{ channel }..."
      new_vids[channel.id] = new_videos(subreddit: subreddit, channel: channel)
    end

    reddit = Reddit.new(subreddit.account)
    reddit.login
    posted_successfully = {}
    new_vids.values.flatten.each do |vid|
      LOGGER.info "Posting #{ vid }..."
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
    
    info_str = new_vids.any? ? "Finished posting videos for #{subreddit}" : "No new videos to post to #{subreddit}"
    LOGGER.info info_str
    LOGGER.info ""
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

  def self.add_tags_to_post_title(title:,subreddit:)
    if subreddit.tags
      matches = subreddit.tags['match']
      regexps = matches.keys
      tag = nil
      regexps.each do |regexp|
        if title.match regexp
          tag = matches[regexp]
          break
        end
      end
      tag = subreddit.tags['default'] unless tag

      "#{tag} #{title}"
    else
      title
    end
  end
end
