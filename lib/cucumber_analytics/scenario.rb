module CucumberAnalytics

  # A class modeling a Cucumber Scenario.

  class Scenario < TestElement

    include Taggable


    # Creates a new Scenario object and, if *source* is provided, populates the
    # object.
    def initialize(source = nil)
      parsed_scenario = process_source(source)

      super(parsed_scenario)

      @tags = []
      @tag_elements = []

      build_scenario(parsed_scenario) if parsed_scenario
    end

    # Returns gherkin representation of the scenario.
    def to_s
      text = ''

      unless tag_elements.empty?
        tag_text = tag_elements.collect { |tag| tag.name }.join(' ')
        text << tag_text + "\n"
      end

      name_text = 'Scenario:'
      name_text += " #{name}" unless name == ''
      text << name_text

      unless description.empty?
        description_text = "\n"
        description_text += description.collect { |line| "\n    #{line}" }.join
        text << description_text
        text << "\n" unless steps.empty?
      end

      unless steps.empty?
        step_text = steps.collect { |step| "\n  #{step.to_s}" }.join
        text << step_text
      end

      text
    end


    private


    def build_scenario(scenario)
      populate_element_tags(scenario)
    end

  end
end
