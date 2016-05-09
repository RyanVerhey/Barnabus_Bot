require 'rubygems'
require 'bundler/setup'
require 'google/api_client'
require 'net/http'
require 'httparty'
require 'json'
require 'yaml'
require 'active_record'
require 'mysql'
require_relative 'variables'
require_relative '../read_write.rb'

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/controllers/*.rb"].each {|file| require file }
Dir["./app/services/*.rb"].each {|file| require file }
