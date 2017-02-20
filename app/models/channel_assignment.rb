class ChannelAssignment < ActiveRecord::Base
  belongs_to :subreddit
  belongs_to :channel

  serialize :regexp

  accepts_nested_attributes_for :subreddit
  accepts_nested_attributes_for :channel
end
