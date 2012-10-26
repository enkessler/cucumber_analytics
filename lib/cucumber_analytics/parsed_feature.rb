module CucumberAnalytics
  class ParsedFeature < FeatureElement


    attr_reader :tags
    attr_accessor :background
    attr_accessor :tests


    # Creates a new ParsedFeature object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      super

      @tags = []
      @tests = []

      parse_feature(source_lines) if source_lines
    end

    # Returns true if the feature contains a background, false otherwise.
    def has_background?
      !@background.nil?
    end

    # Returns the scenarios contained in the feature.
    def scenarios
      @tests.select { |test| test.is_a? ParsedScenario }
    end

    # Returns the outlines contained in the feature.
    def outlines
      @tests.select { |test| test.is_a? ParsedScenarioOutline }
    end

    # Returns the number scenarios contained in the feature.
    def scenario_count
      scenarios.count
    end

    # Returns the number outlines contained in the feature.
    def outline_count
      outlines.count
    end

    # Returns the number of tests contained in the feature.
    def test_count
      @tests.count
    end

    # Returns the number of test cases contained in the feature.
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
