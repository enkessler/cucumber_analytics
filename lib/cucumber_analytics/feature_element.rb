module CucumberAnalytics
  class FeatureElement


    attr_accessor :name
    attr_accessor :description
    attr_accessor :parent_element


    # Creates a new FeatureElement object.
    def initialize(parsed_element = nil)
      CucumberAnalytics::Logging.logger.info('FeatureElement#initialize')

      @name = ''
      @description =[]
      parse_feature_element(parsed_element) if parsed_element
    end


    private


    def parse_feature_element(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element')
      CucumberAnalytics::Logging.logger.debug('Parsed element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      parse_feature_element_name(parsed_element)
      parse_feature_element_description(parsed_element)
    end

    #todo - move this elsewhere
    def parse_feature_element_tags(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_tags')
      CucumberAnalytics::Logging.logger.debug('Parsed element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      if parsed_element['tags']
        parsed_element['tags'].each do |tag|
          @tags << tag['name']
        end
      end
    end

    def parse_feature_element_name(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_name')
      CucumberAnalytics::Logging.logger.debug('Parsed element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      @name = parsed_element['name']
    end

    def parse_feature_element_description(parsed_element)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_description')
      CucumberAnalytics::Logging.logger.debug('Parsed element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      @description = parsed_element['description'].split("\n").collect { |line| line.strip }
      @description.delete('')
    end

  end
end
