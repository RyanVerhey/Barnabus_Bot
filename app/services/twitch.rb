class Twitch
  include HTTParty

  def initialize
    @client_id = ENV['TWITCH_CLIENT_ID']
  end
end
