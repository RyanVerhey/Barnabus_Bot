require "#{ APP_DIR }/app/models/channel.rb"
class YoutubeChannel < Channel
  has_many :videos, class_name: 'YoutubeVideo', foreign_key: 'channel_id'
end
