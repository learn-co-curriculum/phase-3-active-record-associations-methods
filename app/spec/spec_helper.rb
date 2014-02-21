ENV["PLAYLISTER_ENV"] = "test"

require_relative '../config/environment'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.color_enabled = true
  config.formatter = :documentation
  config.order = 'default'

  config.before do
    reset_database
  end
end

def reset_database
  app = Rake.application
  app.init
  app.load_rakefile
  app['db:migrate'].invoke
end
