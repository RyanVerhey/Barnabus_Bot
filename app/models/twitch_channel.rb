require './app/models/channel.rb'
class TwitchChannel < Channel
  has_many :videos, class_name: 'TwitchVideo', foreign_key: 'channel_id'
end
