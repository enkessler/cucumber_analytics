module CucumberAnalytics
  class ParsedBackground < TestElement


    # Creates a new ParsedBackground object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.info('ParsedBackground#initialize')

      super
    end

  end
end
