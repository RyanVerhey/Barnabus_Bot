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
    
  end
end
