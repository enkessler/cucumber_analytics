module CucumberAnalytics

  # A class modeling an basic element of a feature.

  class FeatureElement

    include Sourceable
    include Raw


    # The name of the FeatureElement
    attr_accessor :name

    # The description of the FeatureElement
    attr_accessor :description

    # The parent object that contains *self*
    attr_accessor :parent_element


    # Creates a new FeatureElement object and, if *parsed_element* is provided,
    # populates the object.
    def initialize(parsed_element = nil)
      @name = ''
      @description =[]

      build_feature_element(parsed_element) if parsed_element
    end


    private


    def build_feature_element(parsed_element)
      populate_feature_element_name(parsed_element)
      populate_feature_element_description(parsed_element)
      populate_element_source_line(parsed_element)
      populate_raw_element(parsed_element)
    end

    def populate_feature_element_name(parsed_element)
      @name = parsed_element['name']
    end

    def populate_feature_element_description(parsed_element)
      @description = parsed_element['description'].split("\n").collect { |line| line.strip }
      @description.delete('')
    end

  end
end
