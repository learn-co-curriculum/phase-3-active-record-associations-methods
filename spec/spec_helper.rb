ENV["PLAYLISTER_ENV"] = "test"

require_relative '../config/environment'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'default'

  # config.before do
  #   reset_database
  # end
end

# def reset_database
#   app = Rake.application
#   app.init
#   app.load_rakefile
#   app['db:migrate'].invoke
#   app['db:migrate'].reenable
# end

# def clean_database
#   Artist.delete_all if defined?(Artist) && DB.tables.include?("artists")
#   Song.delete_all if defined?(Song) && DB.tables.include?("songs")
#   Genre.delete_all if defined?(Genre) && DB.tables.include?("genres")
# end
