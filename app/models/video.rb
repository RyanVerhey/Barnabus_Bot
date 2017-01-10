class Video < ActiveRecord::Base
  self.primary_key = "id"

  belongs_to :channel

  def self.without_associated_channel
    all.select { |video| video.channels.empty? }
  end

  def self.save_as_video(upload, video)
    Video.new(upload.video_id, video.published_at, video.title, video.author.uri.split("/").last)
  end

end
