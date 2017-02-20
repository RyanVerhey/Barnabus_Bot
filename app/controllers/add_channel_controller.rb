class AddChannelController
  def self.add_channel(subreddits, arguments)
    filename = arguments.first
    data = YAML.load(File.open(filename))

    channels = data['channels'].each do |channel_data|
      service =
        case channel_data['type']
        when 'twitch' then Twitch
        when 'youtube' then YouTube
        else
          raise "Not a valid channel type"
        end

      channel = service.initialize_channel(channel_data['name'])

      regexp = Regexp.new(channel_data['regexp'])
      subreddits.each do |sub|
        ChannelAssignment.create(subreddit: sub,
                                 channel: channel,
                                 regexp: regexp)

        SubredditService.update_subreddit(sub, channel)
      end
    end
  end
end
