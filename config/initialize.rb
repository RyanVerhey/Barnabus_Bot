APP_DIR ||= File.dirname(File.expand_path(__FILE__)).split('/')[0..-2].join('/')
BARNABUSRB ||= false
require_relative "#{ APP_DIR }/config/requires"
LOGGER = BarnabusLogger.init unless BARNABUSRB

ActiveRecord::Base.establish_connection(
  YAML::load(File.open("#{ APP_DIR }/config/database.yaml"))[ENVIRONMENT]
)
CONN = ActiveRecord::Base.connection
