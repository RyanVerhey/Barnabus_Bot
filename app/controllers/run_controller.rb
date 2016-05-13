class RunController
  def self.run(subreddits)
    subreddits.each do |subreddit|
      subreddit.channels.each do |channel|
        new_recents = YouTube.get_new_recent_videos_for_youtube_channel_and_subreddit(channel: channel, subreddit: subreddit)

        channel.videos = new_recents
        channel.save
      end
    end
  end
end
