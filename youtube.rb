class YouTube
  attr_reader :client, :new_videos

  def initialize
    @client = YouTubeIt::Client.new(:dev_key => ENV['YTKEY'])
    @channels = { yogscastkim: /.+/, yogscastlalna: /(F|f)lux (B|b)uddies/ }
    @new_videos = get_new_videos
  end

  def get_new_videos
    new_videos = []
    videos = fetch_recent_videos
    videos.each do |video|
      if video.published_at > DateTime.parse(get_last_saved_video[:timestamp]).to_time
        new_videos << video
      end
    end
    new_videos
  end

  def fetch_videos
    kim = @client.profile('yogscastkim')
    activity = @client.activity('yogscastkim')
    videos = []
    activity.each do |upload|
      video = @client.video_by(upload.video_id)
      videos << Video.new(upload.video_id, video.updated_at, video.title, video.author.uri.split("/").last)
    end
    videos
  end

  def save_latest_video(video)
    p video
    data = YAML.load(File.read("data.yaml"))
    data = {} if !data
    data["latest_#{video.author}_video".to_sym] = { id: video.id, timestamp: video.updated_at, author: video.author }
    File.open('data.yaml', 'w') { |f| f.write(data.to_yaml) }
  end

end

class Video
  attr_reader :id, :updated_at, :url, :title, :author

  def initialize(id, updated_at, title, author)
    @id = id
    @updated_at = updated_at
    @url = "http://www.youtube.com/watch?v=" + @id
    @title = title
    @author = author
  end

end
