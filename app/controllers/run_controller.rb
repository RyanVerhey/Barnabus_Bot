class RunController
  def self.update_recent_videos(subreddits)
    subreddits = Array(subreddits)
    subreddits.delete_if { |sr| sr.is_a? String }
    subreddits.each do |subreddit|
      SubredditService.update_subreddit(subreddit)
    end
  end

  def self.post_new_videos(subreddits)
    subreddits = Array(subreddits)
    subreddits.delete_if { |sr| sr.is_a? String }
    subreddits.each do |subreddit|
      SubredditService.post_new_videos(subreddit)
    end
  end
end
