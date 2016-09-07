class BarnabusController
  class Command
    @@desc = nil
    @@format = nil
    def desc;    @@desc    end
    def format;  @@format  end
    def action(arg); end
  end

  class Run < Command
    @@desc = "Run & Post to Reddit"
    @@format = "subreddit_name(,subreddit_name)"
    def self.action(subreddits)
      RunController.post_new_videos(subreddits)
    end
  end

  class Update < Command
    @@desc = "Update the DB without posting to Reddit"
    @@format = "subreddit_name(,subreddit_name)"
    def self.action(subreddits)
      RunController.update_recent_videos(subreddits)
      puts "Videos for #{subreddits.join(", ")} successfully updated!"
    end
  end

  class Init < Command
    @@desc = "Make a new subreddit. Follow the directions"
    @@format = "subreddit_name"
    def self.action(subreddits)
      InitController.new_subreddit(subreddits_input.first)
    end
  end

  class AddChannel < Command
    @@desc = "Add a YouTube Channel to an existing subreddit"
    @@format = "subreddit_name"
    def self.action(subreddits)
      # Add a YoutubeChannel to a subreddit
      puts "To be implemented later."
    end
  end

  class DeleteChannel < Command
    @@desc = "Delete a YouTube Channel from an existing subreddit"
    @@format = "subreddit_name"
    def self.action(subreddits)
      # Delete a YoutubeChannel from a subreddit
      puts "To be implemented later."
    end
  end

  class DeleteSubreddit < Command
    @@desc = "Delete a subreddit"
    @@format = "subreddit_name"
    def self.action(subreddits)
      # Delete a subreddit
      puts "To be implemented later."
    end
  end

  class CleanVideos < Command
    @@desc = "Still figuring this one out"
    @@format = ""
    def self.action(subreddits)
      # ??
      puts "To be implemented later."
    end
  end

  class Help < Command
    @@desc = "I hope you know what this does :)"
    @@format = ""
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
  ALIASES = {
    "-h" => Help
  }

  def self.process_command(input, subreddits)
    command = COMMANDS[input] || ALIASES[input]
    if command
      command.action subreddits
    else
      puts "That command is not recognized. Type 'use --help' for a list of commands."
    end
  end
end
