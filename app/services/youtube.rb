class YouTube

  attr_reader :recent_videos

  CLIENT = Google::APIClient.new(
    :application_name => 'Barnabus_Bot',
    :application_version => '3.0.0'
  )
  API = CLIENT.discovered_api('youtube', "v3")
  CLIENT.authorization = nil
  KEY = ENV['YTKEY']

  def initialize(data = {})
    @client = Google::APIClient.new(
      :application_name => 'Barnabus_Bot',
      :application_version => '3.0.0'
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

  def self.get_channel_id(channel_username)
    channel_list = CLIENT.execute(:key => KEY,
                                  :api_method => API.channels.list,
                                  :parameters => { forUsername: channel_username, part: "id" })
    YAML.load(channel_list.body)["items"][0]["id"]
  end

  def self.get_channel_name(channel_username)
    channel_list = CLIENT.execute(:key => KEY,
                                  :api_method => API.channels.list,
                                  :parameters => { forUsername: channel_username, part: "snippet" })
    YAML.load(channel_list.body)["items"][0]["snippet"]["title"]
  end

  def self.get_new_recent_videos_for_youtube_channel_and_subreddit(channel:, subreddit:)
    puts "Fetching #{channel}'s videos from YouTube..."
    assignment = ChannelAssignment.find_by(youtube_channel: channel,
                                           subreddit: subreddit)
    regexp = assignment.regexp

    yt_video_list = CLIENT.execute(:key => KEY,
                                 :api_method => API.search.list,
                                 :parameters => {
                                   channelId: channel.id,
                                   part: "id,snippet",
                                   maxResults: 10,
                                   order: "date",
                                   type: "video" })
    yt_video_ids = YAML.load(yt_video_list.body)["items"].map{ |v| v['id']['videoId'] }
    yt_videos = CLIENT.execute(:key => KEY,
                                :api_method => API.videos.list,
                                :parameters => {
                                  part: "id,snippet",
                                  id: yt_video_ids.join(',') })
    yt_videos = YAML.load(yt_videos.body)["items"]

    videos = yt_videos.map do |video|
      title = video["snippet"]["title"]
      desc = video["snippet"]["description"]
      if regexp.match(title) || regexp.match(desc)
        video_object_from_youtube_video_data(video)
      end
    end.compact

    videos
  end

  def self.get_new_videos_for_subreddit_and_youtube_channel(subreddit:, channel:)
    new_recents = YouTube.get_new_recent_videos_for_youtube_channel_and_subreddit(channel: channel, subreddit: subreddit)

    new_recents.reject { |v| RedditPost.where(subreddit: subreddit, video_id: v.id).first }
  end

  private

  def self.video_object_from_youtube_video_data(video)
    vid = Video.find_or_initialize_by id: video["id"]

    vid.attributes = {
      title: video["snippet"]["title"],
      author: video["snippet"]["channelTitle"],
      description: video["snippet"]["description"],
      published_at: video["snippet"]["publishedAt"]
    }

    vid
  end
end
