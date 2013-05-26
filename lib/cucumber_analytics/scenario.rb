module CucumberAnalytics

  # A class modeling a cucumber Scenario.

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
      CucumberAnalytics::Logging.logger.info('Scenario#parse_scenario')

      parse_element_tags(scenario)
    end

  end
end
