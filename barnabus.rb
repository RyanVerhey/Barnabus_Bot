require_relative 'config/initialize'

input = ARGV
subreddits_input = input[1].split ","
subreddits = Subreddit.where name: subreddits_input

case input.first
when "--run" # Run & Post
  RunController.post_new_videos(subreddits)
when "--update" # Run (update)
  RunController.update_recent_videos(subreddits)
  puts "Videos for #{subreddits.join(", ")} successfully updated!"
when "--init" # Init (make new subreddit)
  InitController.new_subreddit(subreddits_input.first)
when "--add-channel" # Add a YoutubeChannel to a subreddit
  # Add a YoutubeChannel to a subreddit
when "--delete-channel" # Delete a YoutubeChannel from a subreddit
  # Delete a YoutubeChannel from a subreddit
when "--add-subreddit" # Add a Subreddit
  # Add a subreddit
when "--delete-subreddit" # Delete a Subreddit
  # Delete a subreddit
when "--clean-videos" # Cleans up videos without channels
  # Cleans up videos without channels
when "-h", "--help" # Help
  HelpController.help
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
