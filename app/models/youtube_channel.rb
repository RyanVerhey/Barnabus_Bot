class YoutubeChannel < ActiveRecord::Base
  has_and_belongs_to_many :videos
  has_and_belongs_to_many :subreddits
  serialize :regexp

  CLIENT = Google::APIClient.new(
    :application_name => 'Barnabus_Bot',
    :application_version => '3.0.0'
  )
  API = CLIENT.discovered_api('youtube', "v3")
  CLIENT.authorization = nil
  KEY = ENV['YTKEY']

end
