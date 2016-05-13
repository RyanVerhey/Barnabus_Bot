class YoutubeChannel < ActiveRecord::Base
  has_and_belongs_to_many :videos
  has_many :channel_assignments
  has_many :subreddits, through: :channel_assignments
  accepts_nested_attributes_for :channel_assignments
end
