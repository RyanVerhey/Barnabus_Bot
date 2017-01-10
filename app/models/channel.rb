class Channel < ActiveRecord::Base
  self.primary_key = "id"
  has_many :videos
  has_many :channel_assignments
  has_many :subreddits, through: :channel_assignments
  accepts_nested_attributes_for :channel_assignments

  def to_s
    self.name
  end
end
