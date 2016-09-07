class HelpController
  def self.help
    command_top_length = BarnabusController::COMMANDS.reduce(0) do |length,(command,action_class)|
      command_format = "#{command} #{action_class.arg_format}"
      if command_format.length > length
        command_format.length
      else
        length
      end
    end
    aliases = BarnabusController::COMMAND_ALIASES.invert

    BarnabusController::COMMANDS.each do |command,action_class|
      command_format = "#{command} #{action_class.arg_format}"
      puts "#{command_format.ljust(command_top_length)} # #{action_class.desc}"
      puts "  [#{aliases[action_class]}]\n" if aliases[action_class]
    end
  end
end
