module CucumberAnalytics

  # A class modeling a cucumber Feature.

  class Feature < FeatureElement

    include Taggable


    # The Background object contained by the Feature
    attr_accessor :background

    # The TestElement objects contained by the Feature
    attr_accessor :tests


    # Creates a new Feature object and, if *source* is provided, populates the
    # object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Feature#initialize')

      parsed_feature = process_source(source)

      super(parsed_feature)

      @tags = []
      @tests = []

      build_feature(parsed_feature) if parsed_feature
    end

    # Returns true if the feature contains a background, false otherwise.
    def has_background?
      !@background.nil?
    end

    # Returns the scenarios contained in the feature.
    def scenarios
      @tests.select { |test| test.is_a? Scenario }
    end

    # Returns the outlines contained in the feature.
    def outlines
      @tests.select { |test| test.is_a? Outline }
    end

    # Returns the number of scenarios contained in the feature.
    def scenario_count
      scenarios.count
    end

    # Returns the number of outlines contained in the feature.
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

    # Returns the immediate child elements of the feature (i.e. its background
    # and tests).
    def contains
      [@background] + @tests
    end


    private


    def process_source(source)
      case
        when source.is_a?(String)
          parse_feature(source)
        else
          source
      end
    end

    def parse_feature(source_text)
      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first
    end

    def build_feature(parsed_feature)
      CucumberAnalytics::Logging.logger.info('Feature#parse_feature')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      parse_element_tags(parsed_feature) if parsed_feature['tags']
      parse_feature_elements(parsed_feature) if parsed_feature['elements']
    end

    def parse_feature_elements(parsed_feature)
      CucumberAnalytics::Logging.logger.info('Feature#parse_feature_elements')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      parse_background(parsed_feature)
      parse_tests(parsed_feature)
    end

    def parse_background(parsed_feature)
      CucumberAnalytics::Logging.logger.info('Feature#parse_feature')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      background_element = parsed_feature['elements'].select { |element| element['keyword'] == 'Background' }.first

      if background_element
        element = Background.new(background_element)
        element.parent_element = self
        @background = element
      end
    end

    def parse_tests(parsed_feature)
      CucumberAnalytics::Logging.logger.info('Feature#parse_tests')
      CucumberAnalytics::Logging.logger.debug('Parsed feature:')
      CucumberAnalytics::Logging.logger.debug(parsed_feature.to_yaml)

      test_elements = parsed_feature['elements'].select { |element| element['keyword'] == 'Scenario' || element['keyword'] == 'Scenario Outline' }
      test_elements.each do |parsed_test|
        case parsed_test['keyword']
          when 'Scenario'
            element = Scenario.new(parsed_test)
            element.parent_element = self
            @tests << element
          when 'Scenario Outline'
            element = Outline.new(parsed_test)
            element.parent_element = self
            @tests << element
        end
      end
    end

  end
end
