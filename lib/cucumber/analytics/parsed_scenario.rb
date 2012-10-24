module CucumberAnalytics
  class ParsedScenario < FeatureElement


    attr_accessor :tags


    def initialize(source_lines = nil)
      super

      @tags = []

      parse_feature_element(source_lines) if source_lines
    end

    def ==(other_scenario)
      left_steps = steps.collect { |step| step.step_text(with_keywords: false, with_arguments: false) }.flatten
      right_steps = other_scenario.steps.collect { |step| step.step_text(with_keywords: false, with_arguments: false) }.flatten

      left_steps == right_steps
    end


    private


    def parse_feature_element(source_lines)
      parse_feature_element_tags(source_lines)
      super(source_lines)
      parse_feature_element_steps(source_lines)
    end

  end
end
