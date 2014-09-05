class YouTube

  def initialize
    @client = YouTubeIt::Client.new(:dev_key => ENV['YTKEY'])
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
