module CucumberAnalytics
  class ParsedFeature < FeatureElement


#    attr_reader :tags
#    attr_accessor :background
#    attr_accessor :tests


    # Creates a new ParsedFeature object and, if *source_lines* is provided,
    # populates the object.
    def initialize(parsed_feature = nil)
      CucumberAnalytics::Logging.logger.info('ParsedFeature#initialize')

      super

#      @tags = []
#      @tests = []
#
#      parse_feature(source_lines) if source_lines
    end

#    # Returns true if the feature contains a background, false otherwise.
#    def has_background?
#      !@background.nil?
#    end
#
#    # Returns the scenarios contained in the feature.
#    def scenarios
#      @tests.select { |test| test.is_a? ParsedScenario }
#    end
#
#    # Returns the outlines contained in the feature.
#    def outlines
#      @tests.select { |test| test.is_a? ParsedScenarioOutline }
#    end
#
#    # Returns the number scenarios contained in the feature.
#    def scenario_count
#      scenarios.count
#    end
#
#    # Returns the number outlines contained in the feature.
#    def outline_count
#      outlines.count
#    end
#
#    # Returns the number of tests contained in the feature.
#    def test_count
#      @tests.count
#    end
#
#    # Returns the number of test cases contained in the feature.
#    def test_case_count
#      scenario_count + outlines.reduce(0) { |outline_sum, outline|
#        outline_sum += outline.examples.reduce(0) { |example_sum, example|
#          example_sum += example.rows.count
#        }
#      }
#    end
#
#    # Returns the immediate child elements of the feature (i.e. its background
#    # and tests).
#    def contains
#      [@background] + @tests
#    end
#
#
#    private
#
#
#    def parse_feature(source_lines)
#      CucumberAnalytics::Logging.logger.info('ParsedFeature#parse_feature')
#
#      parse_feature_element_tags(source_lines)
#      parse_feature_element(source_lines)
#    end
#
#    def parse_feature_element_description(source_lines)
#      CucumberAnalytics::Logging.logger.info('ParsedFeature#parse_feature_element_description')
#      CucumberAnalytics::Logging.logger.debug('source lines')
#      source_lines.each do |line|
#        CucumberAnalytics::Logging.logger.debug(line.chomp)
#      end
#
#      source_lines.delete_if { |line| World.ignored_line?(line) }
#
#      until source_lines.first =~ /^\s*(?:(?:Scenario: )|(?:Scenario Outline: )|(?:Background: )|(?:@ ))/ or
#          source_lines.empty?
#
#        @description << source_lines.first.strip
#        source_lines.shift
#      end
#    end

  end
end
