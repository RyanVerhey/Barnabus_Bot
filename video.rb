class Video
  attr_reader :id, :published_at, :url, :title, :author

  def initialize(params)
    @id = params[:id]
    @published_at = params[:published_at]
    @url = "https://www.youtube.com/watch?v=" + @id
    @title = params[:title]
    @author = params[:author]
  end

  def self.save_as_video(upload, video)
    Video.new(upload.video_id, video.published_at, video.title, video.author.uri.split("/").last)
  end

end
