require './app/services/video_service_base.rb'
class Twitch < VideoServiceBase
  include HTTParty

  CLIENT_ID = ENV['TWITCH_CLIENT_ID']
  HEADERS = { 'Client-ID' => CLIENT_ID, 'Accept' => 'application/vnd.twitchtv.v5+json' }
  REQUEST_OPTIONS = { headers: HEADERS }
  URL_BASE = "https://api.twitch.tv/kraken/"

  def self.get_new_recent_videos(channel:, subreddit:)
    assignment = ChannelAssignment.find_by(channel: channel,
                                           subreddit: subreddit)
    regexp = assignment.regexp

    response = Twitch.get("#{URL_BASE}channels/#{channel.id}/videos?limit=10&broadcast_type=archive,highlight,upload", REQUEST_OPTIONS)

    video_data = response['videos']

    videos = video_data.map do |video|
      title = video['title']
      desc = video['description'].to_s
      if regexp.match(title) || regexp.match(desc)
        video_object_from_twitch_video_data(video)
      end
    end
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

  def self.video_object_from_twitch_video_data(video)
    vid = TwitchVideo.find_or_initialize_by id: video["_id"]

    vid.attributes = {
      title: video['title'],
      author: video['channel']['display_name'],
      description: video['description'].to_s,
      published_at: video['published_at']
    }

    vid
  end

  def self.channel
    TwitchChannel
  end

  def self.video
    TwitchVideo
  end
end
