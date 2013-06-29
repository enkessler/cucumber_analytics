require 'logger'

module CucumberAnalytics

  # Just a simple wrapper around Ruby's base logging capabilities.

  module Logging

    class << self

      # Sets the log level of the gem's logger.
      def log_level=(log_level)
        logger.level = log_level
      end

      # Gets the log level of the gem's logger.
      def log_level
        logger.level
      end

      # Returns the gem's logging object. Will generate an object if one has
      # not already been set.
      def logger
        unless @logger
          @logger = Logger.new(default_logfile)
          self.log_level = Logger::FATAL
        end

        @logger
      end

      # Sets the gem's logging object.
      def logger=(new_logger)
        @logger = new_logger
      end

      # Sets the file that the default logging object will write to.
      def default_logfile=(file_path)
        @default_logfile = file_path
      end

      # Gets the file that the default logging object will write to.
      def default_logfile
        @default_logfile ||= "#{File.dirname(__FILE__)}/../../ca_logfile.log"
      end

      # A central method for tracking method calls.
      def log_method(name, *args)
        logger.info("Method #{name} called")
        logger.debug("Arguments: #{args}")
      end

    end

  end
end
