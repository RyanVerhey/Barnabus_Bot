class ReadWrite

  def self.load_data
    YAML.load(File.read(File.expand_path(File.dirname(__FILE__)) + "/data.yaml"))
  end

  def self.write_recent_vids(params)
    data = DATA
    data[:reddits][params[:reddit]][:channels].each do |channel_name,channel_data|
      channel_data[:recents] = params[:recents][channel_name]
    end
    self.write(data)
  end

  def self.fetch_recent_videos(channel_name)
    DATA[:reddits][REDDITNAME][:channels][channel_name.to_sym][:recents]
  end

  def self.fetch_reddit_account_info
    DATA[:reddits][REDDITNAME][:account_info]
  end

  private

  def self.write(data)
    File.open(File.expand_path(File.dirname(__FILE__)) + "/data.yaml", 'w') do |f|
      f.write(data.to_yaml)
    end
  end

end