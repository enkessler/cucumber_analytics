module CucumberAnalytics
  class ParsedFeature < FeatureElement


    attr_reader :tags
    attr_accessor :background
#    attr_accessor :tests


    # Creates a new ParsedFeature object and, if *source_lines* is provided,
    # populates the object.
    def initialize(parsed_feature = nil)
      CucumberAnalytics::Logging.logger.info('ParsedFeature#initialize')

      super

      @tags = []
      @tests = []

      parse_feature(parsed_feature) if parsed_feature
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
      scenario_count + outlines.reduce(0) { |outline_sum, outline|
        outline_sum += outline.examples.reduce(0) { |example_sum, example|
          example_sum += example.rows.count
        }
      }
    end

#    # Returns the immediate child elements of the feature (i.e. its background
#    # and tests).
#    def contains
#      [@background] + @tests
#    end


    private


    def parse_feature(parsed_feature)
      CucumberAnalytics::Logging.logger.info('ParsedFeature#parse_feature')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      parse_feature_element_tags(parsed_feature) if parsed_feature['tags']
      parse_feature_elements(parsed_feature) if parsed_feature['elements']
    end

    def parse_feature_elements(parsed_feature)
      CucumberAnalytics::Logging.logger.info('ParsedFeature#parse_feature_elements')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      parse_background(parsed_feature)
      parse_tests(parsed_feature)
    end

    def parse_background(parsed_feature)
      CucumberAnalytics::Logging.logger.info('ParsedFeature#parse_feature')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      background_element = parsed_feature['elements'].select { |element| element['keyword'] == 'Background' }.first
      @background = ParsedBackground.new(background_element) if background_element
    end

    def parse_tests(parsed_feature)
      CucumberAnalytics::Logging.logger.info('ParsedFeature#parse_tests')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      test_elements = parsed_feature['elements'].select { |element| element['keyword'] == 'Scenario' || element['keyword'] == 'Scenario Outline' }
      test_elements.each do |parsed_test|
        case parsed_test['keyword']
          when 'Scenario'
            @tests << ParsedScenario.new(parsed_test)
          when 'Scenario Outline'
            @tests << ParsedScenarioOutline.new(parsed_test)
        end
      end
    end

  end
end
