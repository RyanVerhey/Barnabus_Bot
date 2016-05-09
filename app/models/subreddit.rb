class Subreddit < ActiveRecord::Base
  belongs_to :account, class_name: "RedditAccount", foreign_key: "reddit_account_id"
  has_many :channel_assignments
  has_many :channels, class_name: "YoutubeChannel", through: :channel_assignments, source: :youtube_channel
  accepts_nested_attributes_for :channel_assignments

end
