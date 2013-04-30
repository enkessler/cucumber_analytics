module CucumberAnalytics
  class Scenario < TestElement


    attr_accessor :tags


    # Creates a new Scenario object and, if *source* is provided,
    # populates the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Scenario#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_scenario = process_source(source)

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


    def build_scenario(scenario)
      CucumberAnalytics::Logging.logger.info('Scenario#parse_scenario')

      parse_feature_element_tags(scenario)
    end

  end
end
