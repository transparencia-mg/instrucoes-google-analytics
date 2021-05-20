# config/initializers/timeout.rb
# https://stackoverflow.com/questions/33030781/rack-timeout-turn-off-info-active-logging
Rack::Timeout::Logger.logger = Logger.new("log/timeout.log")
Rack::Timeout::Logger.logger.level = Logger::ERROR
