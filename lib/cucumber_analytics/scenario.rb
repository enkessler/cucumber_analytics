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

      unless description_text.empty?
        text << "\n"

        description_lines = description_text.split("\n")
        text << "  \n" if description_lines.first =~ /\S/

        text << description_lines.collect { |line| "  #{line}" }.join("\n")
        text << "\n" unless steps.empty?
      end

      unless steps.empty?
        step_text = steps.collect { |step| step.to_s.split("\n").collect { |line| line.empty? ? "\n" : "\n  #{line}" }.join }.join
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
