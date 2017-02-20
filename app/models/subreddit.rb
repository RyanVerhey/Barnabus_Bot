class Subreddit < ActiveRecord::Base
  belongs_to :account, class_name: "RedditAccount", foreign_key: "reddit_account_id"
  has_many :channel_assignments
  has_many :channels, through: :channel_assignments
  accepts_nested_attributes_for :channel_assignments

  def to_s
    "/r/" + self.name
  end
end
