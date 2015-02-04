STARTTIME = Time.now

require 'rubygems'
require 'bundler/setup'
require 'google/api_client'
require 'net/http'
require 'httparty'
require 'shenanigans'
require 'json'
require 'yaml'
require_relative 'video'
require_relative 'read_write'
DATA = ReadWrite.load_data
require_relative 'reddit'
require_relative 'youtube'

input = ARGV
REDDITNAME = input[1].to_sym

case input.first
when "-r"
  if DATA[:reddits][REDDITNAME]
    yt = YouTube.new channels: DATA[:reddits][REDDITNAME][:channels]
    yt.recent_videos
    yt.new_videos
    p yt.new_videos.count
    if yt.new_videos.empty?
      puts "No new videos to post!"
    else
      yt.new_videos.each do |video|
        Reddit.submit_video video
      end
      ReadWrite.write_recent_vids(recents: yt.recent_videos, reddit: REDDITNAME)
    end
  else
    puts "That subreddit hasn't been saved yet."
  end
when "-u"
    yt = YouTube.new channels: DATA[:reddits][REDDITNAME][:channels]
    yt.recent_videos
    ReadWrite.write_recent_vids(recents: yt.recent_videos, reddit: REDDITNAME)
    puts "Recent videos for #{REDDITNAME.to_s} successfully updated!"
when "help"
  puts "Hi, I'm Barnabus! Here's a list of my commands:"
  puts "  '-r subreddit':   Searches for new videos and posts them to reddit."
  puts "  '-u subreddit':   Only updates the most recent videos in the database, doesn't post anything to reddit. If it is a new channel/subreddit, initializes the values."
  puts "  'help':           I hope you know what this does :)"
else
  puts "That command is not recognized. Type 'help' for a list of commands."
end
