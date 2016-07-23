load 'config/requires.rb'

ActiveRecord::Base.establish_connection(
  YAML::load(File.open('config/database.yaml'))[ENVIRONMENT]
)
CONN = ActiveRecord::Base.connection
