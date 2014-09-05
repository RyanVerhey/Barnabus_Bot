class YouTube

  def initialize
    @client = YouTubeIt::Client.new(:dev_key => ENV['YTKEY'])
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
