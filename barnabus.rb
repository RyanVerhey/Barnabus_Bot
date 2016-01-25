STARTTIME = Time.now

require 'rubygems'
require 'bundler/setup'
require 'google/api_client'
require 'net/http'
require 'httparty'
require 'json'
require 'yaml'
require_relative 'video'
require_relative 'read_write'
require_relative 'reddit'
require_relative 'youtube'

DATA = ReadWrite.load_data

input = ARGV
REDDITNAME = input[1].to_sym if input[1]

if !ENV["YTKEY"]
  raise "You need to set the YouTube API Key!"
elsif !ENV["PASS"]
  raise "You need to set the Reddit password!"
end

case input.first
when "-r"
  if DATA[:reddits][REDDITNAME]
    puts "Getting videos for /r/#{REDDITNAME.to_s}. Took #{Time.now - STARTTIME} seconds to initialize..."
    yt = YouTube.new channels: DATA[:reddits][REDDITNAME][:channels]
    yt.recent_videos
    yt.new_videos
    if yt.new_videos.empty?
      puts "No new videos to post!"
    else
      yt.new_videos.each do |video|
        Reddit.submit_video video
      end
      ReadWrite.write_recent_vids(recents: yt.recent_videos, reddit: REDDITNAME)
    end
    end_time = Time.now
  else
    puts "That subreddit hasn't been saved yet."
  end
when "-u"
    yt = YouTube.new channels: DATA[:reddits][REDDITNAME][:channels]
    yt.recent_videos
    ReadWrite.write_recent_vids(recents: yt.recent_videos, reddit: REDDITNAME)
    puts "Recent videos for #{REDDITNAME.to_s} successfully updated!"
    end_time = Time.now
when "help"
  puts "Hi, I'm Barnabus! Here's a list of my commands:"
  puts "  '-r subreddit':   Searches for new videos and posts them to reddit."
  puts "  '-u subreddit':   Only updates the most recent videos in the database, doesn't post anything to reddit. If it is a new channel/subreddit, initializes the values."
  puts "  'help':           I hope you know what this does :)"
else
  puts "That command is not recognized. Type 'help' for a list of commands."
end

if end_time
  puts "Barnabus took #{(end_time - STARTTIME)} seconds to run."
  puts "Start time: #{STARTTIME}"
  puts "End time: #{end_time}"
end
