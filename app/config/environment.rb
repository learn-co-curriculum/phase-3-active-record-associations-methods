require 'bundler/setup'
Bundler.require

require 'active_record'
require 'rake'

Dir[File.join(File.dirname(__FILE__), "../models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

DBRegistry[ENV["PLAYLISTER_ENV"]].connect!
DB = ActiveRecord::Base.connection