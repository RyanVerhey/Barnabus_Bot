class Subreddit < ActiveRecord::Base
  belongs_to :reddit_account
  has_and_belongs_to_many :youtube_channels

end
