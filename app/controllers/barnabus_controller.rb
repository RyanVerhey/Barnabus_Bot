class BarnabusController
  class Command
    def self.desc; nil end
    def self.arg_format; nil end
    def self.action(arg); end
  end

  class Run < Command
    def self.desc; "Run & Post to Reddit" end
    def self.arg_format; "subreddit_name(,subreddit_name)" end
    def self.action(subreddits)
      RunController.post_new_videos(subreddits)
    end
  end

  class Update < Command
    def self.desc; "Update the DB without posting to Reddit" end
    def self.arg_format; "subreddit_name(,subreddit_name)" end
    def self.action(subreddits)
      RunController.update_recent_videos(subreddits)
      puts "Videos for #{subreddits.join(", ")} successfully updated!"
    end
  end

  class Init < Command
    def self.desc; "Make a new subreddit. Follow the directions" end
    def self.arg_format; "subreddit_name" end
    def self.action(subreddits)
      InitController.new_subreddit(subreddits_input.first)
    end
  end

  class AddChannel < Command
    def self.desc; "Add a YouTube Channel to an existing subreddit" end
    def self.arg_format; "subreddit_name" end
    def self.action(subreddits)
      # Add a YoutubeChannel to a subreddit
      puts "To be implemented later."
    end
  end

  class DeleteChannel < Command
    def self.desc; "Delete a YouTube Channel from an existing subreddit" end
    def self.arg_format; "subreddit_name" end
    def self.action(subreddits)
      # Delete a YoutubeChannel from a subreddit
      puts "To be implemented later."
    end
  end

  class DeleteSubreddit < Command
    def self.desc; "Delete a subreddit" end
    def self.arg_format; "subreddit_name" end
    def self.action(subreddits)
      # Delete a subreddit
      puts "To be implemented later."
    end
  end

  class CleanVideos < Command
    def self.desc; "Still figuring this one out" end
    def self.arg_format; "" end
    def self.action(subreddits)
      # ??
      puts "To be implemented later."
    end
  end

  class Help < Command
    def self.desc; "I hope you know what this does :)" end
    def self.arg_format; "" end
    def self.action(subreddits)
      HelpController.help
    end
  end

  COMMANDS = {
    "--run"              => Run,
    "--update"           => Update,
    "--init"             => Init,
    "--add-channel"      => AddChannel,
    "--delete-channel"   => DeleteChannel,
    "--delete-subreddit" => DeleteSubreddit,
    "--clean-videos"     => CleanVideos,
    "--help"             => Help
    # "-h"                 => Help
  }
  COMMAND_ALIASES = {
    "-h" => Help
  }

  def self.process_command(input, subreddits)
    command = COMMANDS[input] || COMMAND_ALIASES[input]
    if command
      command.action subreddits
    else
      puts "That command is not recognized. Type 'use --help' for a list of commands."
    end
  end
end
