class BarnabusController
  COMMANDS = {
    "--run" => {
      desc: "Run & Post to Reddit",
      format: "subreddit_name(,subreddit_name)",
      action: :run
    },
    "--update" => {
      desc: "Update the DB without posting to Reddit",
      format: "subreddit_name(,subreddit_name)",
      action: :update
    },
    "--init" => {
      desc: "Make a new subreddit. Follow the directions",
      format: "subreddit_name",
      action: :init
    },
    "--add-channel" => {
      desc: "Add a YouTube Channel to an existing subreddit",
      format: "subreddit_name",
      action: :add_channel
    },
    "--delete-channel" => {
      desc: "Delete a YouTube Channel from an existing subreddit",
      format: "subreddit_name",
      action: :delete_channel
    },
    "--delete-subreddit" => {
      desc: "Delete a subreddit",
      format: "subreddit_name",
      action: :delete_channel
    },
    "--clean-videos" => {
      desc: "Still figuring this one out",
      format: "",
      action: :clean_videos
    },
    "--help" => {
      desc: "I hope you know what this does :)",
      format: "",
      action: :help
    }
  }

  COMMAND_ALIASES = {
    "-h" => COMMANDS["--help"]
  }

  def self.process_command(command, subreddits)
    options = COMMANDS[command] || COMMAND_ALIASES[command]
    if options
      self.send options[:action], subreddits
      # command[:action].call
    else
      puts "That command is not recognized. Type 'use --help' for a list of commands."
    end
  end

  def self.run(subreddits)
    RunController.post_new_videos(subreddits)
  end

  def self.update(subreddits)
    RunController.update_recent_videos(subreddits)
    puts "Videos for #{subreddits.join(", ")} successfully updated!"
  end

  def self.init(subreddits)
    puts "Videos for #{subreddits.join(", ")} successfully updated!"
  end

  def self.add_channel(subreddits)
    # Add a YoutubeChannel to a subreddit
    puts "To be implemented later."
  end

  def self.delete_channel(subreddits)
    # Delete a YoutubeChannel from a subreddit
    puts "To be implemented later."
  end

  def self.delete_subreddit(subreddits)
    # Delete a subreddit
    puts "To be implemented later."
  end

  def self.clean_videos(subreddits)
    # ??
    puts "To be implemented later."
  end

  def self.help(subreddits)
    HelpController.help
  end
end
