APP_DIR = File.dirname(File.expand_path(__FILE__))
LOGGER = Logger.new File.open("#{APP_DIR}/log/barnabus.log")
require_relative "#{ APP_DIR }/config/initialize"

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
