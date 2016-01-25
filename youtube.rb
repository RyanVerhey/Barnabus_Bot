class YouTube

  attr_reader :recent_videos

  def initialize(data = {})
    @client = Google::APIClient.new(
      :application_name => 'Barnabus_Bot',
      :application_version => '2.0.0'
    )
    @api = @client.discovered_api('youtube', "v3")
    @client.authorization = nil
    @key = ENV['YTKEY']
    @channels = data.fetch(:channels, {})
    @recent_videos = recent_vids
    @new_videos = new_vids if data[:fetch_new]
  end

  def new_videos
    @new_videos ||= new_vids
  end

  private

  def recent_vids
    raise "Can't fetch videos - no channels defined." if @channels.empty?

    recents = {}
    @channels.each do |channel,data|
      puts "Fetching #{channel.to_s} videos..."
      channel_list = @client.execute(:key => @key,
                                     :api_method => @api.channels.list,
                                     :parameters => { forUsername: channel.to_s, part: "id" })
      channel_id = YAML.load(channel_list.body)["items"][0]["id"]
      video_list = @client.execute(:key => @key,
                                   :api_method => @api.search.list,
                                   :parameters => {
                                     channelId: channel_id,
                                     part: "id,snippet",
                                     maxResults: 10,
                                     order: "date",
                                     type: "video" })
      videos = YAML.load(video_list.body)["items"]

      sorted_videos = []
      videos.each do |video|
        title = video["snippet"]["title"]
        # desc =
        if data[:regexp].match(title)
          sorted_videos <<
            Video.new(id: video["id"]["videoId"],
                      published_at: video["snippet"]["publishedAt"],
                      title: video["snippet"]["title"],
                      author: video["snippet"]["channelTitle"])
        end
      end
      recents[channel] = sorted_videos
    end
    recents
  end

  def new_vids
    new_vids = []
    if @recent_videos
      @recent_videos.each do |channel_name,videos|
        videos.each do |video|
          if YouTube.new?(channel_name.to_s, video.id)
            new_vids << video
          end
        end
      end
    else
      raise "Can't get new videos if you haven't fetched recent videos first!"
    end
    new_vids
  end

  def update

  end

  private

  def self.new?(channel,video_id)
    new = false
    old_recents = ReadWrite.fetch_recent_videos(channel)
    ids = old_recents.inject([]) { |arr,vid| arr << vid.id }
    ids.include?(video_id) ? false : true
  end

end
