module CucumberAnalytics
  class ParsedFeature < FeatureElement


    attr_reader :tags
    attr_accessor :background
    attr_accessor :tests


    def initialize(source_lines = nil)
      super

      @tags = []
      @tests = []

      parse_feature(source_lines) if source_lines
    end

    def has_background?
      !@background.nil?
    end

    def scenarios
      @tests.select { |test| test.is_a? ParsedScenario }
    end

    def outlines
      @tests.select { |test| test.is_a? ParsedScenarioOutline }
    end

    def scenario_count
      scenarios.count
    end

    def outline_count
      outlines.count
    end

    def test_count
      @tests.count
    end

    def test_case_count
      scenario_count + outlines.reduce(0) { |sum, outline| sum += outline.examples.count }
    end

    def contains
      [@background] + @tests
    end


    private


    def parse_feature(source_lines)
      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)
    end

  end
end
