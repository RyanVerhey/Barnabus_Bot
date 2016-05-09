class YoutubeChannel < ActiveRecord::Base
  has_and_belongs_to_many :videos
  has_many :channel_assignments
  has_many :subreddits, through: :channel_assignments
  accepts_nested_attributes_for :channel_assignments

  CLIENT = Google::APIClient.new(
    :application_name => 'Barnabus_Bot',
    :application_version => '3.0.0'
  )
  API = CLIENT.discovered_api('youtube', "v3")
  CLIENT.authorization = nil
  KEY = ENV['YTKEY']

end
