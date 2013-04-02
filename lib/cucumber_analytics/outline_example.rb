module CucumberAnalytics
  class OutlineExample < FeatureElement


    attr_accessor :tags
    attr_accessor :rows
    attr_accessor :parameters


    # Creates a new OutlineExample object and, if *source_lines* is provided,
    # populates the object.
    def initialize(parsed_example = nil)
      CucumberAnalytics::Logging.logger.info('OutlineExample#initialize')
      CucumberAnalytics::Logging.logger.debug('OutlineExample:')
      CucumberAnalytics::Logging.logger.debug(parsed_example.to_yaml)


      super

      @tags = []
      @rows = []
      @parameters = []

      parse_example(parsed_example) if parsed_example
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

    # Returns tags which are applicable to the example block which have been
    # inherited from the outline level.
    def applied_tags
      additional_tags = @parent_element.tags
      additional_tags.concat(@parent_element.applied_tags) if @parent_element.respond_to?(:applied_tags)

      additional_tags
    end

    # Returns all tags which are applicable to the example block.
    def all_tags
      applied_tags + @tags
    end


    private


    def parse_example(parsed_example)
      CucumberAnalytics::Logging.logger.info('OutlineExample#parse_example')
      CucumberAnalytics::Logging.logger.debug('Parsed example:')
      CucumberAnalytics::Logging.logger.debug(parsed_example.to_yaml)

      parse_feature_element_tags(parsed_example)

      @parameters = parsed_example['rows'].first['cells']

      parsed_example['rows'].shift
      parsed_example['rows'].each do |row|
        @rows << Hash[@parameters.zip(row['cells'])]
      end
    end

  end
end
