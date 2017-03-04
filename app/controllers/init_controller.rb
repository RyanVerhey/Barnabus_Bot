class InitController

  def initialize(data)
    @data = data
  end

  def self.new_subreddit(subreddit, filename)
    data = YAML.load File.open "#{ APP_DIR }/#{filename.first}"
    self.new(data).send(:add_subreddit)
  end

  private

  def add_subreddit
    @subreddit = instantiate_subreddit
    @reddit_account = instantiate_or_find_reddit_account
    @channels = instantiate_or_find_channels

    save_all
  end

  def instantiate_subreddit
    subreddit_data = @data['subreddit']
    subreddit = Subreddit.find_or_initialize_by(name: subreddit_data['name'])
    tags = subreddit_data['tags']

    if tags
      tags['match'] = tags['match'].inject({}) do |hsh,(regexp,tag)|
        regexp = Regexp.new(regexp, Regexp::IGNORECASE)
        hsh[regexp] = tag
        hsh
      end
    end
    subreddit.tags = tags

    check_for_existing_subreddit subreddit
    subreddit
  end

  def check_for_existing_subreddit(subreddit)
    unless subreddit.new_record?
      LOGGER.error "Subreddit #{ subreddit } already in database"
      exit
    end
  end

  def instantiate_or_find_reddit_account
    account_data = @data['subreddit']['reddit_account']
    account = RedditAccount.find_or_initialize_by(username: account_data['name'])
    if account.new_record?
      account.password_var = account_data['password_var']
    end
    account
  end

  def instantiate_or_find_channels
    channel_data = @data['subreddit']['channels']
    channels = channel_data.map do |c|
      channel_class = SubredditService.channel_for_channel_type(c['type'])
      channel = channel_class.find_or_initialize_by(name: c['name'])
      channel.regexp = Regexp.new(c['regexp'], Regexp::IGNORECASE)
      yt_channel_data = YouTube.youtube_channel_data username: c['username'], id: c['id']
      if channel.new_record?
        channel.name = yt_channel_data[:name]
        channel.id = yt_channel_data[:id]
        channel.username = c['username']
      end
      channel
    end
    channels
  end

  def save_all
    @reddit_account.save if @reddit_account.new_record?
    @subreddit.account = @reddit_account
    @subreddit.save
    @channels.each(&:save)

    @channels.each do |channel|
      ChannelAssignment.create(channel: channel, subreddit: @subreddit, regexp: channel.regexp)
    end

    RunController.update_recent_videos(@subreddit)
  end

end
