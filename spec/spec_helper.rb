ENV["PLAYLISTER_ENV"] = "test"

require_relative '../config/environment'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'default'

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def reset_database
  `rake db:migrate`
end

def clean_database
  Artist.delete_all if defined?(Artist) && DB.tables.include?("artists")
  Song.delete_all if defined?(Song) && DB.tables.include?("songs")
  Genre.delete_all if defined?(Genre) && DB.tables.include?("genres")
end
