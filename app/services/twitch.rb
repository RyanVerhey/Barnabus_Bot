require './app/services/video_service_base.rb'
class Twitch  < VideoServiceBase
  include HTTParty

  def initialize
    @client_id = ENV['TWITCH_CLIENT_ID']
  end

  def self.get_new_recent_videos(channel:, subreddit:)
    # get new recent videos
  end
end
