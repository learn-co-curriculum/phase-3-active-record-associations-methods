ENV['RACK_ENV'] = 'test'
require_relative "../config/environment"
require "sinatra/activerecord/rake"
require "rake"

# Define task context in case Rake complains
Rake::Task.define_task(:environment)

# Ensure migrations run before tests
Rake::Task["db:migrate"].reenable
Rake::Task["db:migrate"].invoke

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
