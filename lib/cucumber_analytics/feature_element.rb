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
      CucumberAnalytics::Logging.logger.info('FeatureElement#initialize')
      CucumberAnalytics::Logging.logger.debug('parsed_element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element)

      @name = ''
      @description =[]

      parse_feature_element(parsed_element) if parsed_element
    end


    private


    def parse_feature_element(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element')
      CucumberAnalytics::Logging.logger.debug('parsed_element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      parse_feature_element_name(parsed_element)
      parse_feature_element_description(parsed_element)
    end

    def parse_feature_element_name(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_name')
      CucumberAnalytics::Logging.logger.debug('parsed_element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      @name = parsed_element['name']
    end

    def parse_feature_element_description(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_description')
      CucumberAnalytics::Logging.logger.debug('parsed_element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      @description = parsed_element['description'].split("\n").collect { |line| line.strip }
      @description.delete('')
    end

  end
end
