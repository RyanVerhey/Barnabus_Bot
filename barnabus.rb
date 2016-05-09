require_relative 'config/initialize'

input = ARGV
subreddit = input[1] || :all

case input.first
when "-rp" # Run & Post
  # Run Barnabus and post
when "-r" # Run (update)
  # Run Barnabus without posting (updating)
when "-i" # Init (make new subreddit)
  # Make a new subreddit
when "-h" # Help
  puts "Hi, I'm Barnabus! Here's a list of my commands:"
  puts " -rp subreddit_name        Run & Post to Reddit"
  puts " -r subreddit_name         Run, but without posting to Reddit"
  puts " -i subreddit_name         Make a new subreddit. Follow the directions"
  puts " -h                        I hope you know what this does :)"
else
  puts "That command is not recognized. Use the '-h' switch for a list of commands."
end

# case
# when !ENV["YTKEY"] && !ENV["PASS"]
#   raise "You need to set the YouTube API Key and the Reddit password!"
# when !ENV["YTKEY"]
#   raise "You need to set the YouTube API Key!"
# when !ENV["PASS"]
#   raise "You need to set the Reddit password!"
# end
#
# case input.first
# when "-r", "-u" # Run, Update
#   DATA = ReadWrite.load_data
#
#   if DATA[:reddits][REDDITNAME]
#     puts "Getting videos for /r/#{REDDITNAME.to_s}..."
#     yt = YouTube.new channels: DATA[:reddits][REDDITNAME][:channels]
#
#     case input.first
#     when "-r" # Run
#       if yt.new_videos.empty?
#         puts "No new videos to post!"
#       else
#         yt.new_videos.each do |video|
#           Reddit.submit_video video
#         end
#         ReadWrite.write_recent_vids(recents: yt.recent_videos, reddit: REDDITNAME)
#       end
#
#     when "-u" # Update
#       ReadWrite.write_recent_vids(recents: yt.recent_videos, reddit: REDDITNAME)
#       puts "Recent videos for #{REDDITNAME.to_s} successfully updated!"
#
#     end
#
#   else
#     puts "That subreddit hasn't been saved yet."
#   end
#
# when "help" #Help
#   puts "Hi, I'm Barnabus! Here's a list of my commands:"
#   puts "  '-r subreddit':   Searches for new videos and posts them to reddit."
#   puts "  '-u subreddit':   Only updates the most recent videos in the database, doesn't post anything to reddit. If it is a new channel/subreddit, initializes the values."
#   puts "  'help':           I hope you know what this does :)"
#
# else
#   puts "That command is not recognized. Type 'help' for a list of commands."
# end
