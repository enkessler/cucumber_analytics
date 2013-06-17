module CucumberAnalytics

  # A class modeling an element that contains steps.

  class TestElement < FeatureElement

    # The steps contained by the TestElement
    attr_accessor :steps


    # Creates a new TestElement object and, if *parsed_test_element* is provided,
    # populates the object.
    def initialize(parsed_test_element = nil)
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", "parsed_test_element = #{parsed_test_element}")

      super

      @steps = []

      build_test_element(parsed_test_element) if parsed_test_element
    end

    # Returns true if the two elements have equivalent steps and false otherwise.
    def ==(other_element)
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      steps == other_element.steps
    end

    # Returns the immediate child elements of the element.
    def contains
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @steps
    end


    private


    def process_source(source)
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      case
        when source.is_a?(String)
          parse_test_element(source)
        else
          source
      end
    end

    def parse_test_element(source_text)
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      base_file_string = "Feature: Fake feature to parse\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first['elements'].first
    end

    def build_test_element(parsed_test_element)
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      parse_test_element_steps(parsed_test_element)
    end

    def parse_test_element_steps(parsed_test_element)
      CucumberAnalytics::Logging.log_method("TestElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

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
