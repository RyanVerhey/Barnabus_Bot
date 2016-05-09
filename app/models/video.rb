class Video < ActiveRecord::Base
  self.primary_key = "id"

  def self.save_as_video(upload, video)
    Video.new(upload.video_id, video.published_at, video.title, video.author.uri.split("/").last)
  end

end
