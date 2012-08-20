require 'bundler'
Bundler.require

require 'valyrian'
require 'yaml'

Mongoid.load!("config/database.yml")
run Valyrian::Service::App.new
