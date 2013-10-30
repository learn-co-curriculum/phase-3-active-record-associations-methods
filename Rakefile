task :environment do
  require_relative 'config/environment'
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => "db/playlister-development.db"
  )

  DB = ActiveRecord::Base.connection
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)

end

namespace :db do
  task :migrate => :environment do
    DB.tables.each do |table|
      DB.execute("DROP TABLE #{table}")
    end

    Dir[File.join(File.dirname(__FILE__), "/migrations", "*.rb")].each do |f| 
      require f
      migration = Kernel.const_get(f.split("/").last.split(".rb").first.gsub(/\d+/, "").split("_").collect{|w| w.strip.capitalize}.join())
      migration.migrate(:up)
    end
  end
end

task :console => :environment do
  Pry.start
end