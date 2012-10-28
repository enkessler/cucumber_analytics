module CucumberAnalytics
  class ParsedBackground < TestElement


    # Creates a new ParsedBackground object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.debug('ParsedBackground#initialize')

      super

      parse_background(source_lines) if source_lines
    end


    private


    def parse_background(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
    end

  end
end
