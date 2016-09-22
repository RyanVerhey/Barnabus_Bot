class AddChannelController
  def self.add_channel(channel_name)

  end

  def self.youtube_channel_exists_in_db?(channel_name)
    !!YoutubeChannel.where("name = :channel_name OR username = :channel_name", channel_name: channel_name).first
  end
end
