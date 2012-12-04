module CucumberAnalytics
  module Logging

    class << self

      def set_log_level(log_level)
        logger.level = log_level
      end

      def logger
        @logger ||= Logger.new('logfile.log')
      end

      def logger=(new_logger)
        @logger = new_logger
      end

    end

  end
end
