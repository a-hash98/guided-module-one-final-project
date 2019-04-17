require 'bundler'
require 'rest-client'
require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'active_record'
require 'rake'
#require_all '../lib'
Bundler.require
require_relative '../lib/user.rb'
require_relative '../lib/game.rb'
require_relative '../lib/gameplay.rb'
require_relative '../lib/cli.rb'
require_relative '../formulate_hangman.rb'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = Logger.new(STDOUT)
