class InitController

  def initialize(reddit_name)
    @reddit_name = reddit_name
    @input = ""
  end

  def self.new_subreddit(reddit_name)
    self.new(reddit_name).send(:new_subreddit)
  end

  protected

  def new_subreddit
    raise "You need to specify the subreddit you want to add" unless @reddit_name

    subreddit = Subreddit.new(name: @reddit_name)
    yt_channels = get_youtube_channels
    subreddit.channels = yt_channels

    if subreddit.save
      puts "Thanks! Updating most recent videos..."
      # Update videos
      stylized_list = subreddit.channels.map(&:name)
      stylized_list[-1] = "and #{stylized_list.last}"
      stylized_list.join(", ")
      puts "Done! Now Barnabus will post videos from #{stylized_list} on /r/#{@reddit_name}"
    end
  end

  def get_youtube_channels
    puts "OK, you want to add #{@reddit_name}."
    puts "Type the name of the YouTube channel you want videos posted to"
    puts "/r/#{@reddit_name}, followed by ` << ` (without the tick marks)"
    puts "then the regular expression you want to match the videos on."
    puts "Ex.: yogscastkim << /Flux Buddies/i"
    puts "Type 'stop' to stop entering YouTube channels"
    channels = []

    until @input == "stop"
      channel = ask_for_new_youtube_channel
      channels << channel if channel
    end

    if channels.empty?
      puts "You need to input at least one YouTube Channel"
      channels = get_youtube_channels
    end

    channels
  end

  def ask_for_new_youtube_channel
    @input = STDIN.gets.chomp!

    return if @input == "stop"
    @input = @input.split(" << ")
    @input[-1] = (eval(@input.last) rescue nil)
    unless @input.last.is_a? Regexp
      puts "You need to enter a valid Regular Expression"
      return
    end

    channel = YoutubeChannel.find_or_initialize(name: @input.first)
    # TODO: With regexps being stored in join table, need to find a way to save them and add to subreddit
    channel.regexp = @input.last
    channel
  end
end
