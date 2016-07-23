class RunController
  def self.update_recent_videos(subreddits)
    subreddits.each do |subreddit|
      subreddit.channels.each do |channel|
        new_recents = YouTube.get_new_recent_videos_for_youtube_channel_and_subreddit(channel: channel, subreddit: subreddit)

        channel.videos += new_recents
        channel.save

        new_recents.each do |vid|
          RedditPost.create(
            subreddit: subreddit,
            video: vid
          )
        end
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
      posted_successfully = {}
      new_vids.values.flatten.each do |vid|
        posted_successfully[vid.id] = reddit.submit_video video: vid, subreddit: subreddit
      end

      subreddit.channels.each do |channel|
        channel.videos += new_vids[channel.to_s]
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

      puts "" # To put a line break in between subreddits
    end
  end
end
