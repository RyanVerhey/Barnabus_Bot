require 'rubygems'
require 'bundler/setup'
require 'net/http'
require 'httparty'
require 'youtube_it'
require 'json'
require 'yaml'
require_relative 'reddit'
require_relative 'youtube'

reddit = YogscastKim.new
# puts reddit
# puts reddit.submit('Test Video', 'https://www.youtube.com/watch?v=S5_mHgxSRzQ', 'GildedGrizzly')
