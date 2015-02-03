start_time = Time.now

require 'rubygems'
require 'bundler/setup'
require 'google/api_client'
require 'net/http'
require 'httparty'
require 'json'
require 'yaml'
require_relative 'reddit'
require_relative 'youtube'
require_relative 'read_write'

input = ARGV

data = ReadWrite.load_data
puts data
# 
# client = Google::APIClient.new(
#   :application_name => 'Barnabus_Bot',
#   :application_version => '1.0.0'
# )
# yt = client.discovered_api('youtube', "v3")
# client.authorization = nil
# key = ENV['YTKEY']
# result = client.execute :key => key, :api_method => yt.playlist_items.list, :parameters => { playlistId: "UUUxoapwoGN9cKN5SPKGVh7A", part: "snippet", maxResults: 10 }
#p  YAML.load(result.body)#["items"].each { |x| p x }
# youtube_client = YouTube.get_video_time { YouTube.new }

# if input.first == "save_newest"
#   youtube_client.save_most_recent_video
# else
#   Reddit.submit_video(youtube_client.new_videos)
# end

# end_time = Time.now
# puts " "
# puts "Time Elapsed: " + (end_time - start_time).to_s
# puts " "
# puts "Start time: " + start_time.to_s
# puts "End time: " + end_time.to_s

