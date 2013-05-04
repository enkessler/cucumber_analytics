require 'logger'
require 'yaml'

module CucumberAnalytics

  # Just a simple wrapper around Ruby's base logging capabilities.

  module Logging

    class << self

      # Sets the log level of the gem's logger.
      def set_log_level(log_level)
        logger.level = log_level
      end

      # Returns the gem's logging object. Will generate an object if one has
      # not already been set.
      def logger
        unless @logger
          @logger = Logger.new("#{File.dirname(__FILE__)}/../../logfile.log")
          set_log_level(Logger::FATAL)
        end

        @logger
      end

      # Sets the gem's logging object.
      def logger=(new_logger)
        @logger = new_logger
      end

    end

  end
end
