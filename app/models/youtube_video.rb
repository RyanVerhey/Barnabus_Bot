require './app/models/video.rb'
class YoutubeVideo < Video
  belongs_to :channel, class_name: 'YoutubeChannel', foreign_key: 'video_id'
end
