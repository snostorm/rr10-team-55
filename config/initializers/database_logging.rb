# Be sure to restart your server when you modify this file.

class DatabaseLogging
#  puts "Initializing DatabaseLogging"
  # log the database messages separately from the main log so the SQL dumps don't clutter the log
  ActiveRecord::Base.logger = Logger.new("#{::Rails.root}/log/#{::Rails.env}_database.log")
  ActiveRecord::Base.logger.formatter = Logger::Formatter.new
#  ActiveRecord::Base.logger.level = Logger::INFO # should set the DB log_level to info to skip SQL dumps
end