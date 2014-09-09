start_time = Time.now

require 'rubygems'
require 'bundler/setup'
require 'net/http'
require 'httparty'
require 'youtube_it'
require 'json'
require 'yaml'
require_relative 'reddit'
require_relative 'youtube'
require_relative 'post_to_reddit'

input = ARGV
reddit_client = YogscastKim.new
youtube_client = YouTube.new

if input.first == "save_newest"
  youtube_client.save_most_recent_video
  puts "Saved newest video"
else
  PostToReddit.post(youtube_client.new_videos, reddit_client)
end

end_time = Time.now
puts " "
puts "Time Elapsed: " + (end_time - start_time).to_s
puts " "
puts "Start time: " + start_time.to_s
puts "End time: " + end_time.to_s

