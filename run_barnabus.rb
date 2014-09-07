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
else
  PostToReddit.post(youtube_client.new_videos, reddit_client)
end
