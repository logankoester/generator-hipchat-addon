require 'logger'
require 'http_logger'
HttpLogger.logger = Logger.new(STDOUT)
HttpLogger.log_headers = true
