module CucumberAnalytics
  class ParsedFile


    attr_reader :feature
    attr_accessor :parent_element


    # Creates a new ParsedFile object and, if *file_parsed* is provided,
    # populates the object.
    def initialize(file_parsed = nil)
      CucumberAnalytics::Logging.logger.info('ParsedFile#initialize')

      parse_file(file_parsed) if file_parsed
    end

    # Returns the name of the file.
    def name
      File.basename(@file.gsub('\\', '/'))
    end

    # Returns the path of the file.
    def path
      @file
    end

    # Returns the immediate child elements of the feature file(i.e. its
    # feature).
    def contains
      @feature ? [@feature] : []
    end

    # Returns the number of features contained in the file.
    def feature_count
      @feature.nil? ? 0 : 1
    end


    private


    def parse_file(file_to_parse)
      CucumberAnalytics::Logging.logger.info('ParsedFile#parse_file')
      CucumberAnalytics::Logging.logger.debug("Parsing file: #{file_to_parse}")

      source_text = IO.read(file_to_parse)
      parsed_file = Parsing::parse_text(source_text)

      CucumberAnalytics::Logging.logger.debug('Parsed file:')
      CucumberAnalytics::Logging.logger.debug(parsed_file.to_yaml)

      @file = file_to_parse
      @feature = nil

      unless parsed_file.empty?
        feature_found = ParsedFeature.new(parsed_file.first)
        feature_found.parent_element = self
        @feature = feature_found
      end
    end

  end
end
