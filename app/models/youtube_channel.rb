class YoutubeChannel < ActiveRecord::Base
  has_and_belongs_to_many :videos
  has_many :channel_assignments
  has_many :subreddits, through: :channel_assignments
  accepts_nested_attributes_for :channel_assignments

  def recent_videos(subreddit)
    assignment = channel_assignments.find_by(subreddit: subreddit)
    videos.where('title REGEXP :regexp OR description REGEXP :regexp', { regexp: assignment.regexp.source }).limit(10)
  end

  def to_s
    self.name
  end
end
