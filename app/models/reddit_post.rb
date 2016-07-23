class RedditPost < ActiveRecord::Base
  belongs_to :video
  belongs_to :subreddit
end
