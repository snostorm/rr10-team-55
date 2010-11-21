# Config the logger to a timestamped format
class LoggingFormatter < ActiveSupport::BufferedLogger
#  puts "Initializing LoggingFormatter"
  logger = Logger.new(File.dirname(__FILE__) + "/../../log/#{::Rails.env}.log") 
  logger.formatter = Logger::Formatter.new
end