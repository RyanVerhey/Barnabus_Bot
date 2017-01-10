require './app/services/video_service_base.rb'
class Twitch  < VideoServiceBase
  include HTTParty

  CLIENT_ID = ENV['TWITCH_CLIENT_ID']
  HEADERS = { 'Client-ID' => CLIENT_ID, 'Accept' => 'application/vnd.twitchtv.v5+json' }
  REQUEST_OPTIONS = { headers: HEADERS }
  URL_BASE = "https://api.twitch.tv/kraken/"

  def self.get_new_recent_videos(channel:, subreddit:)
    # get new recent videos
  end

  def self.initialize_channel(name)
    channel =
      TwitchChannel.find_or_initialize_by(name: name)

    if channel.new_record?
      response = Twitch.get("#{URL_BASE}search/channels/?query=#{name}", REQUEST_OPTIONS)

      channel_data = response['channels'].try(:first)
      username = channel_data['name']
      name = channel_data['display_name']
      id = channel_data['_id']

      channel.id = id
      channel.name = name
      channel.username = username
      channel.save
    end

    channel
  end

  def self.channel
    TwitchChannel
  end

  def self.video
    TwitchVideo
  end
end
