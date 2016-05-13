class RunController
  def self.update_recent_videos(subreddits)
    subreddits.each do |subreddit|
      subreddit.channels.each do |channel|
        new_recents = YouTube.get_new_recent_videos_for_youtube_channel_and_subreddit(channel: channel, subreddit: subreddit)

        channel.videos = new_recents
        channel.save
      end
      puts "" # To put a line break in between subreddits
    end
  end

  def self.post_new_videos(subreddits)
    subreddits.each do |subreddit|
      new_vids = {}
      subreddit.channels.each do |channel|
        new_vids[channel.to_s] = YouTube.get_new_videos_for_subreddit_and_youtube_channel(subreddit: subreddit, channel: channel)
      end

      reddit = Reddit.new(subreddit.account)
      reddit.login
      new_vids.values.flatten.each do |vid|
        reddit.submit_video video: vid, subreddit: subreddit
      end

      subreddit.channels.each do |channel|
        channel.videos += new_vids[channel.to_s]
        channel.save
      end

      puts "" # To put a line break in between subreddits
    end
  end
end
