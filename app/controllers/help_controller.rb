class HelpController
  def self.help
    puts "Hi, I'm Barnabus! Here's a list of my commands:"
    puts " -rp subreddit_name(,subreddit_name)        Run & Post to Reddit"
    puts " -r subreddit_name(,subreddit_name)         Run, but without posting to Reddit"
    puts " -i subreddit_name                          Make a new subreddit. Follow the directions"
    puts " -un subreddit_name                         Add a YouTube Channel to an existing subreddit"
    puts " -ud subreddit_name                         Delete a YouTube Channel from an existing subreddit"
    puts " -uds subreddit_name                        Delete a subreddit"
    puts " -h                                         I hope you know what this does :)"
  end
end
