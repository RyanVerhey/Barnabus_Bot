class Subreddit < ActiveRecord::Base
  belongs_to :account, class_name: "RedditAccount", foreign_key: "reddit_account_id"
  has_many :channel_assignments
  has_many :channels, through: :channel_assignments
  has_many :posts, class_name: "RedditPost"
  has_many :videos, through: :posts
  serialize :tags
  accepts_nested_attributes_for :channel_assignments

  def to_s
    "/r/" + self.name
  end
end
