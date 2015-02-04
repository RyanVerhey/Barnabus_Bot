class YouTube

  def initialize(data = {})
    @client = Google::APIClient.new(
      :application_name => 'Barnabus_Bot',
      :application_version => '2.0.0'
    )
    @api = @client.discovered_api('youtube', "v3")
    @client.authorization = nil
    @key = ENV['YTKEY']
    @channels = data.fetch(:channels, [])
    @recents = nil
    @new_vids = nil
  end

  def recent_videos(force = false)
    if !@recents || force
      if @channels.empty?
        raise "Can't fetch videos - no channels defined."
      end
      recents = {}
      @channels.each do |channel|
        # find 10 most recent videos
        #   add them to recent_videos with channel name as key
      end
      @recents = recents
    else
      @recents
    end
  end

  def new_videos(force = false)
    if !@new_vids || force
      new_vids = {}
      # iterate through fetched videos
      #   if YouTube.new?(channel,video_id)
      #     add it to new videos with channel as key
      @new_vids = new_vids
    else
      @new_vids
    end
  end

  def update

  end

  private

  def self.new?(channel,video_id)
    # if video is not in recent videos from data for that channel
    #   return true
    # else
    #   return false
  end

end

=begin
class YouTube
  attr_reader :client, :new_videos

  def initialize
   @client = YouTubeIt::Client.new(:dev_key => ENV['YTKEY'])
   @channels = YouTube.access_data("r")[:channels]
   @new_videos = get_new_videos
  end

  def get_new_videos
    new_videos = []
    videos = fetch_recent_videos
    videos.each do |video|
      if video.published_at > newest_video_timestamp
        new_videos << video
      end
    end
    new_videos
  end

  def fetch_recent_videos
    videos = []
    @channels.each do |channel_name, regex|
      activity = @client.activity(channel_name.to_s)
      puts "#{channel_name}: #{activity.length} videos"
      activity.each do |upload|
        video = @client.video_by(upload.video_id)
        if regex.match(video.title)
          videos << Video.save_as_video(upload, video)
        end
      end
    end
    videos.sort_by! { |video| video.published_at }
  end

  def self.save_video_data(video)
    data = { latest_video: { id: video.id, timestamp: video.published_at.to_s, author: video.author, title: video.title, saved_at: Time.now } }
    YouTube.access_data("w", data)
  end

  def self.access_data(read_write, *save_data)
    data = YAML.load(File.read(File.expand_path(File.dirname(__FILE__)) + "/data.yaml"))
    data = {} if !data
    case read_write
    when 'r'
      return data
    when 'w'
      save_data.first.each do |key, value|
        data[key] = value
      end
      File.open(File.expand_path(File.dirname(__FILE__)) + "/data.yaml", 'w') { |f| f.write(data.to_yaml) }
    end
  end

  def get_last_saved_video
    last_saved_video = YouTube.access_data("r")[:latest_video]
  end

  def save_most_recent_video
    if @new_videos.last
      YouTube.save_video_data(@new_videos.last)
      puts "Saved newest videos"
    else
      puts "No new video to save"
    end
  end

  def newest_video_timestamp
    last_saved_timestamp = self.get_last_saved_video[:timestamp]
    (last_saved_timestamp = DateTime.parse(last_saved_timestamp).to_time) if last_saved_timestamp
    if last_saved_timestamp
      last_saved_timestamp
    else
      save_most_recent_video
      Time.now
    end
  end

  def self.get_video_time(&blk)
    puts "Initializing YouTube:"
    yt_time = Time.now
    client = blk.call
    puts Time.now - yt_time
    client
  end

end
=end

class Video
  attr_reader :id, :published_at, :url, :title, :author

  def initialize(id, published_at, title, author)
    @id = id
    @published_at = published_at
    @url = "http://www.youtube.com/watch?v=" + @id
    @title = title
    @author = author
  end

  def self.save_as_video(upload, video)
    Video.new(upload.video_id, video.published_at, video.title, video.author.uri.split("/").last)
  end

end
