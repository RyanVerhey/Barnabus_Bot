class YouTube

  def initialize
    @client = YouTubeIt::Client.new(:dev_key => ENV['YTKEY'])
  end

end
