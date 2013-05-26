module CucumberAnalytics
  class Example < FeatureElement

    include Taggable

    attr_accessor :rows
    attr_accessor :parameters


    # Creates a new Example object and, if *source* is provided,
    # populates the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Example#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_example = process_source(source)

      super(parsed_example)

      @tags = []
      @rows = []
      @parameters = []

      build_example(parsed_example) if parsed_example
    end

    # Adds a row to the example block. The row can be given as a Hash of column
    # headers and their corresponding values or as an Array of values which
    # will be assigned in order.
    def add_row(row)
      if row.is_a?(Array)
        @rows << Hash[@parameters.zip(row.collect { |value| value.strip })]
      else
        @rows << row
      end
    end

    # Removes a row from the example block. The row can be given as a Hash of
    # column headers and their corresponding values or as an Array of values
    # which will be assigned in order.
    def remove_row(row)
      if row.is_a?(Array)
        location = @rows.index { |row_hash| row_hash.values_at(*@parameters) == row }
      else
        location = @rows.index { |row_hash| row_hash == row }
      end
      @rows.delete_at(location) if location
    end


    private


    def process_source(source)
      case
        when source.is_a?(String)
          parse_example(source)
        else
          source
      end
    end

    def parse_example(source_text)
      base_file_string = "Feature: Fake feature to parse\nScenario Outline:\n* fake step\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first['elements'].first['examples'].first
    end

    def build_example(parsed_example)
      CucumberAnalytics::Logging.logger.info('Example#parse_example')
      CucumberAnalytics::Logging.logger.debug('Parsed example:')
      CucumberAnalytics::Logging.logger.debug(parsed_example.to_yaml)

      parse_element_tags(parsed_example)

      @parameters = parsed_example['rows'].first['cells']

      parsed_example['rows'].shift
      parsed_example['rows'].each do |row|
        @rows << Hash[@parameters.zip(row['cells'])]
      end
    end

  end
end
