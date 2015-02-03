class ReadWrite
  
  def self.load_data
    YAML.load(File.read(File.expand_path(File.dirname(__FILE__)) + "/data.yaml"))
  end
  
end