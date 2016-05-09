class ChannelAssignment < ActiveRecord::Base
  belongs_to :subreddit
  belongs_to :youtube_channel

  serialize :regexp

  accepts_nested_attributes_for :subreddit
  accepts_nested_attributes_for :youtube_channel
end
