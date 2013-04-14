module CucumberAnalytics
  class ParsedScenario < TestElement


    attr_accessor :tags


    # Creates a new ParsedScenario object and, if *source_lines* is provided,
    # populates the object.
    def initialize(scenario = nil)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#initialize')
      CucumberAnalytics::Logging.logger.debug('Scenario:')
      CucumberAnalytics::Logging.logger.debug(scenario.to_yaml)

      super

      @tags = []

      parse_scenario(scenario) if scenario
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


    def parse_scenario(scenario)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#parse_scenario')

      parse_feature_element_tags(scenario)
    end

  end
end
