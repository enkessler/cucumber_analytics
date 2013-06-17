module CucumberAnalytics

  # A class modeling an basic element of a feature.

  class FeatureElement

    # The name of the FeatureElement
    attr_accessor :name

    # The description of the FeatureElement
    attr_accessor :description

    # The parent object that contains *self*
    attr_accessor :parent_element


    # Creates a new FeatureElement object and, if *parsed_element* is provided,
    # populates the object.
    def initialize(parsed_element = nil)
      CucumberAnalytics::Logging.log_method("FeatureElement##{__method__}", "parsed_element = #{parsed_element}")

      @name = ''
      @description =[]

      parse_feature_element(parsed_element) if parsed_element
    end


    private


    def parse_feature_element(parsed_element)
      CucumberAnalytics::Logging.log_method("FeatureElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      parse_feature_element_name(parsed_element)
      parse_feature_element_description(parsed_element)
    end

    def parse_feature_element_name(parsed_element)
      CucumberAnalytics::Logging.log_method("FeatureElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @name = parsed_element['name']
    end

    def parse_feature_element_description(parsed_element)
      CucumberAnalytics::Logging.log_method("FeatureElement##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @description = parsed_element['description'].split("\n").collect { |line| line.strip }
      @description.delete('')
    end

  end
end
