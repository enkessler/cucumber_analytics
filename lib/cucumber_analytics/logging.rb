module CucumberAnalytics
  module Logging

    def self.logger
      @logger ||= Log4r::Logger.new('ca_logger')
    end

  end
end
