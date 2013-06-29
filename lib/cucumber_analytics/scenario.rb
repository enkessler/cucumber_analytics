module CucumberAnalytics

  # A class modeling a Cucumber Scenario.

  class Scenario < TestElement

    include Taggable


    # Creates a new Scenario object and, if *source* is provided, populates the
    # object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      parsed_scenario = process_source(source)

      super(parsed_scenario)

      @tags = []

      build_scenario(parsed_scenario) if parsed_scenario
    end


    private


    def build_scenario(scenario)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      populate_element_tags(scenario)
    end

  end
end
