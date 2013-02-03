module CucumberAnalytics
  class OutlineExample < FeatureElement


    attr_accessor :tags
    attr_accessor :rows
    attr_accessor :parameters


    # Creates a new OutlineExample object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.info('OutlineExample#initialize')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each { |line| CucumberAnalytics::Logging.logger.debug(line.chomp) } if source_lines

      super

      @tags = []
      @rows = []
      @parameters = []

      parse_example(source_lines) if source_lines
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

    # Returns tags which have been inherited from the outline level.
    def applied_tags
      additional_tags = @parent_element.tags
      additional_tags.concat(@parent_element.applied_tags) if @parent_element.respond_to?(:applied_tags)

      additional_tags
    end

    # Returns all tags which are applicable to the scenario.
    def all_tags
      applied_tags.concat(@tags)
    end

    private


    def parse_example(source_lines)
      CucumberAnalytics::Logging.logger.info('OutlineExample#parse_example')

      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)

      source_lines.delete_if { |line| World.ignored_line?(line) }

      unless source_lines.empty?
        @parameters = source_lines.shift.split('|')
        @parameters.shift
        @parameters.pop

        @parameters.collect! { |param| param.strip }
      end

      unless source_lines.empty?
        @rows = source_lines.collect { |row| row.split('|') }.collect do |row|
          row.shift
          row.collect { |value| value.strip }
        end

        @rows.collect! { |row| Hash[@parameters.zip(row)] }
      end
    end

    def parse_feature_element_description(source_lines)
      CucumberAnalytics::Logging.logger.info('OutlineExample#parse_feature_element_description')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      until source_lines.first =~ /^\s*\|/ or
          source_lines.empty?

        unless World.ignored_line?(source_lines.first)
          @description << source_lines.first.strip
        end

        source_lines.shift
      end
    end

  end
end
