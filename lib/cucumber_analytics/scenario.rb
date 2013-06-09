module CucumberAnalytics

  # A class modeling a Cucumber Scenario.

  class Scenario < TestElement

    include Taggable


    # Creates a new Scenario object and, if *source* is provided, populates the
    # object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Scenario#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_scenario = process_source(source)

      super(parsed_scenario)

      @tags = []

      build_scenario(parsed_scenario) if parsed_scenario
    end


    private


    def build_scenario(scenario)
      CucumberAnalytics::Logging.logger.info('Scenario#build_scenario')
      CucumberAnalytics::Logging.logger.debug('scenario:')
      CucumberAnalytics::Logging.logger.debug(scenario.to_yaml)

      parse_element_tags(scenario)
    end

  end
end
