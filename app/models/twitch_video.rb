require './app/models/video.rb'
class TwitchVideo < Video
  belongs_to :channel, class_name: 'TwitchChannel', foreign_key: 'video_id'
end
