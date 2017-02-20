require "#{ APP_DIR }/app/models/video.rb"
class YoutubeVideo < Video
  belongs_to :channel, class_name: 'YoutubeChannel', foreign_key: 'video_id'

  def url
    "https://www.youtube.com/watch?v=" + id
  end
end
