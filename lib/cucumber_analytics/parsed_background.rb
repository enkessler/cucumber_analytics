module CucumberAnalytics
  class ParsedBackground < TestElement


    # Creates a new ParsedBackground object and, if *source* is provided,
    # populates the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('ParsedBackground#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_background = process_source(source)

      super(parsed_background)
    end

  end
end
