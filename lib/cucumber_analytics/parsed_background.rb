module CucumberAnalytics
  class ParsedBackground < TestElement


    def initialize(source_lines = nil)
      super

      parse_background(source_lines) if source_lines
    end


    private


    def parse_background(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
    end

  end
end
