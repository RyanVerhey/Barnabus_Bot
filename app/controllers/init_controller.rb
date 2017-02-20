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
    @input = ""
    raise "You need to specify the subreddit you want to add" unless @reddit_name

    subreddit = Subreddit.where(name: @reddit_name).first_or_initialize
    if !subreddit.new_record?
      puts "You need to enter a new subreddit! /r/#{@reddit_name} already exists in the database"
      return
    end
    assignments = get_youtube_channels

    save_successfully = []
    assignments.each do |assignment|
      assignment.subreddit = subreddit
      save_successfully << assignment.valid?
    end
    save_successfully.uniq!
    save_successfully.compact!
    # If there are 2 values, then they're true and false, therefore something
    # isn't valid. If there's one value and it's true, then true. If not, then
    # false.
    save_successfully = (save_successfully.count == 1 && save_successfully.first)

    if save_successfully
      account = get_reddit_account
      account.save
      subreddit.account = account
      assignments.map(&:save)
      puts "Thanks! Updating most recent videos..."
      # TODO: Update videos
      stylized_list = subreddit.channels.map(&:name)
      stylized_list = stylized_list.join(", ")
      puts "Done! Now Barnabus will post videos from #{stylized_list} on /r/#{@reddit_name}"
    else
      puts "Something went wrong, please try again."
      new_subreddit
    end
  end

  def get_youtube_channels
    puts "OK, you want to add #{@reddit_name}."
    puts "Type the name of the YouTube channel you want videos posted to"
    puts "/r/#{@reddit_name}, followed by ` << ` (without the tick marks)"
    puts "then the regular expression you want to match the videos on."
    puts "Ex.: yogscastkim << /Flux Buddies/i"
    puts "Type 'stop' to stop entering YouTube channels"
    assignments = []

    until @input == "stop"
      assignment = ask_for_new_youtube_channel
      assignments << assignment if assignment
    end

    if assignments.empty?
      puts "You need to input at least one YouTube Channel"
      @input = ""
      assignments = get_youtube_channels
    end

    assignments
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

    channel = YoutubeChannel.find_or_initialize_by(name: @input.first)

    begin
      channel.id = YouTube.get_channel_id channel.name
    rescue NoMethodError
      puts "Not a valid YouTube Channel! Please try again"
      return
    end

    assignment = ChannelAssignment.new(regexp: @input.last)
    assignment.youtube_channel = channel
    puts "Thanks! Please input another YouTube Channel & Regexp (type 'stop' to finish):"
    assignment
  end

  def get_reddit_account
    puts "What account do you want to post from?"
    puts "Enter a name of an existing account or type a new one."
    puts "Existing accounts: " + RedditAccount.all.map(&:username).join(", ")
    input = STDIN.gets.chomp!

    account = RedditAccount.where(username: input).first_or_initialize
    if account.new_record?
      puts "What will the password environment variable be?"
      account.password_var = STDIN.gets.chomp!
    else
      puts "Barnabus will use the account #{account.username} to post to reddit"
    end

    account
  end
end
