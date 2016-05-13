class Video < ActiveRecord::Base
  self.primary_key = "id"

  has_and_belongs_to_many :channels, class_name: "YoutubeChannel"

  def self.save_as_video(upload, video)
    Video.new(upload.video_id, video.published_at, video.title, video.author.uri.split("/").last)
  end

end
