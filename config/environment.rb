require 'bundler/setup'
Bundler.require

require 'active_record'

Dir[File.join(File.dirname(__FILE__), "../models", "*.rb")].each {|f| require f}