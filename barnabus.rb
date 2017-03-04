APP_DIR = File.dirname(File.expand_path(__FILE__))
BARNABUSRB = true
require_relative "#{ APP_DIR }/config/initialize"
LOGGER = BarnabusLogger.init

input = ARGV
command = input.shift
subreddit_inputs = input.shift.to_s.split ","
subreddits = subreddit_inputs.map do |subreddit_input|
  Subreddit.where(name: subreddit_inputs).first || subreddit_input
end
arguments = input

begin
  BarnabusController.process_command command: command,
                                     subreddits: subreddits,
                                     arguments: arguments

rescue => e
  LOGGER.fatal e
  raise e
end
