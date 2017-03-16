class DeleteChannelController
  def self.delete_channel(subreddits, arguments)
    filename = arguments.first
    data = YAML.load(File.open(filename))

    Channel.where(username: data['channels']).each do |channel|
      channel.videos.destroy_all
      channel.channel_assignments.destroy_all
      channel.destroy
    end
  end
end
