module CucumberAnalytics

  # A class modeling a Cucumber .feature file.

  class FeatureFile

    # The Feature object contained by the FeatureFile
    attr_accessor :feature

    # The parent object that contains *self*
    attr_accessor :parent_element


    # Creates a new FeatureFile object and, if *file_parsed* is provided,
    # populates the object.
    def initialize(file_parsed = nil)
      CucumberAnalytics::Logging.logger.info('FeatureFile#initialize')
      CucumberAnalytics::Logging.logger.debug('file_parsed:')
      CucumberAnalytics::Logging.logger.debug(file_parsed)

      if file_parsed
        raise(ArgumentError, "Unknown file: #{file_parsed.inspect}") unless File.exists?(file_parsed)
        parse_file(file_parsed)
      end
    end

    # Returns the name of the file.
    def name
      CucumberAnalytics::Logging.logger.info('FeatureFile#name')

      File.basename(@file.gsub('\\', '/'))
    end

    # Returns the path of the file.
    def path
      CucumberAnalytics::Logging.logger.info('FeatureFile#path')

      @file
    end

    # Returns the immediate child elements of the file(i.e. its Feature object).
    def contains
      CucumberAnalytics::Logging.logger.info('FeatureFile#contains')

      @feature ? [@feature] : []
    end

    # Returns the number of features contained in the file.
    def feature_count
      CucumberAnalytics::Logging.logger.info('FeatureFile#feature_count')

      @feature.nil? ? 0 : 1
    end


    private


    def parse_file(file_to_parse)
      CucumberAnalytics::Logging.logger.info('FeatureFile#parse_file')
      CucumberAnalytics::Logging.logger.debug('file_to_parse:')
      CucumberAnalytics::Logging.logger.debug(file_to_parse)


      source_text = IO.read(file_to_parse)
      parsed_file = Parsing::parse_text(source_text)

      CucumberAnalytics::Logging.logger.debug('parsed_file:')
      CucumberAnalytics::Logging.logger.debug(parsed_file.to_yaml)

      @file = file_to_parse
      @feature = nil

      unless parsed_file.empty?
        feature_found = Feature.new(parsed_file.first)
        feature_found.parent_element = self
        @feature = feature_found
      end
    end

  end
end
