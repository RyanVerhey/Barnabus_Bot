class AddChannelController
  def self.add_channel(subreddit, channels)

  end

  def self.find_or_create_youtube_channel(channel_name)
    if youtube_channel_exists_in_db? channel_name
      fetch_youtube_channel channel_name
    else
      # Fetch channel info
    end
  end

  def self.youtube_channel_exists_in_db?(channel_name)
    !!fetch_youtube_channel(channel_name)
  end

  def self.fetch_youtube_channel(channel_name)
    YoutubeChannel.where("name = :channel_name OR username = :channel_name", channel_name: channel_name).first
  end
end
