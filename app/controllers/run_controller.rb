class RunController
  def self.update_recent_videos(subreddits)
    subreddits.delete_if { |sr| sr.is_a? String }
    subreddits.each do |subreddit|
      SubredditService.update_subreddit(subreddit)

      puts "" # To put a line break in between subreddits
    end
  end

  def self.post_new_videos(subreddits)
    subreddits.delete_if { |sr| sr.is_a? String }
    subreddits.each do |subreddit|
      SubredditService.post_new_videos(subreddit)

      puts "" # To put a line break in between subreddits
    end
  end
end
