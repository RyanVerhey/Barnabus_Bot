require_relative 'config/initialize'

input = ARGV
command = input.shift
subreddit_inputs = input.shift.to_s.split ","
subreddits = subreddit_inputs.map do |subreddit_input|
  Subreddit.where(name: subreddit_inputs).first || subreddit_input
end
arguments = input

BarnabusController.process_command command: command,
                                   subreddits: subreddits,
                                   arguments: arguments
