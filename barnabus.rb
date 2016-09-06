require_relative 'config/initialize'

input = ARGV
subreddit_inputs = input[1].to_s.split ","
subreddits = Subreddit.where name: subreddit_inputs

BarnabusController.process_command input.first, subreddits
