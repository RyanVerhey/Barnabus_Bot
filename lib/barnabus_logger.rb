class BarnabusLogger < Logger
  def self.init
    new File.new("#{APP_DIR}/log/barnabus.log", "a+")
  end

  def add(severity, message = nil, progname = nil, &block)
    puts_str = "#{progname}"
    puts_str += "\n#{message}" if message
    puts puts_str if @puts
    super
  end
end
