module CucumberAnalytics
  class ParsedScenario < TestElement


    attr_accessor :tags


    def initialize(source_lines = nil)
      super

      @tags = []

      parse_scenario(source_lines) if source_lines
    end


    private


    def parse_scenario(source_lines)
      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
    end

  end
end
