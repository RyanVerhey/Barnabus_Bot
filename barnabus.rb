require_relative 'config/initialize'

input = ARGV
subreddits_input = input[1].to_s.split ","
subreddits = Subreddit.where name: subreddits_input

COMMANDS = {
  "--run" => {
    desc: "Run & Post to Reddit",
    format: "subreddit_name(,subreddit_name)",
    action: ->{
      RunController.post_new_videos(subreddits)
    }
  },
  "--update" => {
    desc: "Update the DB without posting to Reddit",
    format: "subreddit_name(,subreddit_name)",
    action: ->{
      RunController.update_recent_videos(subreddits)
      puts "Videos for #{subreddits.join(", ")} successfully updated!"
    }
  },
  "--init" => {
    desc: "Make a new subreddit. Follow the directions",
    format: "subreddit_name",
    action: ->{
      puts "Videos for #{subreddits.join(", ")} successfully updated!"
    }
  },
  "--add-channel" => {
    desc: "Add a YouTube Channel to an existing subreddit",
    format: "subreddit_name",
    action: ->{
      # Add a YoutubeChannel to a subreddit
      puts "To be implemented later."
    }
  },
  "--delete-channel" => {
    desc: "Delete a YouTube Channel from an existing subreddit",
    format: "subreddit_name",
    action: ->{
      # Delete a YoutubeChannel from a subreddit
      puts "To be implemented later."
    }
  },
  "--delete-subreddit" => {
    desc: "Delete a subreddit",
    format: "subreddit_name",
    action: ->{
      # Delete a subreddit
      puts "To be implemented later."
    }
  },
  "--clean-videos" => {
    desc: "Still figuring this one out",
    format: "",
    action: ->{
      # ??
      puts "To be implemented later."
    }
  },
  "--help" => {
    desc: "I hope you know what this does :)",
    format: "",
    action: ->{
      HelpController.help
    }
  }
}
COMMAND_ALIASES = {
  "-h" => COMMANDS["--help"]
}

command = COMMANDS[input.first] || COMMAND_ALIASES[input.first]
if command
  command[:action].call
else
  puts "That command is not recognized. Type 'use --help' for a list of commands."
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
