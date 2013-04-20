module CucumberAnalytics
  class ParsedScenario < TestElement


    attr_accessor :tags


    # Creates a new ParsedScenario object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_scenario = parse_source(source)

      super(parsed_scenario)


      @tags = []

      build_scenario(parsed_scenario) if parsed_scenario
    end

    # Returns tags which are applicable to the scenario which have been
    # inherited from the feature level.
    def applied_tags
      @parent_element.all_tags
    end

    # Returns all tags which are applicable to the scenario.
    def all_tags
      applied_tags + @tags
    end


    private


    def parse_source(source)
      case
        when source.is_a?(String)
          parse_scenario(source)
        else
          source
      end
    end

    def parse_scenario(source_text)
      base_file_string = "Feature: Fake feature to parse\n"
      source_text = base_file_string + source_text

      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      parser.parse(source_text, 'fake_file.txt', 0)
      formatter.done
      parsed_file = JSON.parse(io.string)

      parsed_file.first['elements'].first
    end

    def build_scenario(scenario)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#parse_scenario')

      parse_feature_element_tags(scenario)
    end

  end
end
