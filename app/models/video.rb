class Video < ActiveRecord::Base
  self.primary_key = "id"

  belongs_to :channel
  has_many :reddit_posts, foreign_key: :video_id

  before_destroy do
    reddit_posts.each do |post|
      post.destroy
    end
  end

  def self.without_associated_channel
    all.select { |video| video.channels.empty? }
  end

  def self.save_as_video(upload, video)
    Video.new(upload.video_id, video.published_at, video.title, video.author.uri.split("/").last)
  end

  def to_s
    "#{ title } - #{ channel } (#{ id })"
  end

end
