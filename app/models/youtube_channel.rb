class YoutubeChannel < ActiveRecord::Base
  has_many :videos
  has_many :channel_assignments
  has_many :subreddits, through: :channel_assignments
  accepts_nested_attributes_for :channel_assignments

  def recent_videos(subreddit)
    regexp = channel_assignments.find_by(subreddit: subreddit).regexp
    videos.all.order("published_at DESC").limit(10).select { |v| regexp.match(v.title) || regexp.match(v.description) }
  end

  def to_s
    self.name
  end
end
