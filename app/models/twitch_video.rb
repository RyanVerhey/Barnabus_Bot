require "#{ APP_DIR }/app/models/video.rb"
class TwitchVideo < Video
  belongs_to :channel, class_name: 'TwitchChannel', foreign_key: 'video_id'

  def url
    "https://www.twitch.tv/yogscastkim/v/" + id.gsub("v","")
  end
end
