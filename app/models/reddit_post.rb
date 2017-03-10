class RedditPost < ActiveRecord::Base
  belongs_to :video
  belongs_to :subreddit
  
  validates :video_id, uniqueness: { scope: :subreddit_id }
end
