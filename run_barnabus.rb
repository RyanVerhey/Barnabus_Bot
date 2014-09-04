require 'rubygems'
require 'bundler/setup'
require 'net/http'
require 'httparty'
require 'json'
require_relative 'reddit'

reddit = YogscastKim.new
# puts reddit
puts reddit.submit('Test title', 'Test message', 'GildedGrizzly', false)
