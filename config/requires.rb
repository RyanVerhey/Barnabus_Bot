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

Dir["#{ APP_DIR }/app/models/*.rb"].each {|file| require file }
Dir["#{ APP_DIR }/app/controllers/*.rb"].each {|file| require file }
Dir["#{ APP_DIR }/app/services/*.rb"].each {|file| require file }
