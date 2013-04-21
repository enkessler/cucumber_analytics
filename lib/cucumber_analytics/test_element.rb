module CucumberAnalytics
  class TestElement < FeatureElement


    attr_accessor :steps


    # Creates a new TestElement object.
    def initialize(parsed_test_element = nil)
      CucumberAnalytics::Logging.logger.info('TestElement#initialize')
      CucumberAnalytics::Logging.logger.debug('parsed_test_element:')
      CucumberAnalytics::Logging.logger.debug(parsed_test_element.to_yaml)

      super

      @steps = []

      build_test_element(parsed_test_element) if parsed_test_element
    end

    # Returns true if the two elements have the same steps, minus any keywords
    # and arguments, and false otherwise.
    def ==(other_element)
      steps == other_element.steps
    end

    # Returns the immediate child elements of the test.
    def contains
      @steps
    end


    private


    def process_source(source)
      case
        when source.is_a?(String)
          parse_test_element(source)
        else
          source
      end
    end

    def parse_test_element(source_text)
      base_file_string = "Feature: Fake feature to parse\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first['elements'].first
    end

    def build_test_element(parsed_test_element)
      CucumberAnalytics::Logging.logger.info('TestElement#parse_test_element')
      CucumberAnalytics::Logging.logger.debug('Parsed test element:')
      CucumberAnalytics::Logging.logger.debug(parsed_test_element.to_yaml)

      parse_test_element_steps(parsed_test_element)
    end

    def parse_test_element_steps(parsed_test_element)
      CucumberAnalytics::Logging.logger.info('TestElement#parse_test_element_steps')
      CucumberAnalytics::Logging.logger.debug('Parsed test element:')
      CucumberAnalytics::Logging.logger.debug(parsed_test_element.to_yaml)

      if parsed_test_element['steps']
        parsed_test_element['steps'].each do |step|
          element = Step.new(step)
          element.parent_element = self
          @steps << element
        end
      end
    end

  end
end
