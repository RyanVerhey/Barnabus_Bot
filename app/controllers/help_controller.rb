class HelpController
  def self.help
    command_top_length = BarnabusController::COMMANDS.reduce(0) do |length,(command,options)|
      command_format = "#{command} #{options[:format]}"
      if command_format.length > length
        command_format.length
      else
        length
      end
    end
    aliases = BarnabusController::COMMAND_ALIASES.invert

    BarnabusController::COMMANDS.each do |command,options|
      command_format = "#{command} #{options[:format]}"
      puts "#{command_format.ljust(command_top_length)} # #{options[:desc]}"
      puts "  [#{aliases[options]}]\n" if aliases[options]
    end
  end
end
