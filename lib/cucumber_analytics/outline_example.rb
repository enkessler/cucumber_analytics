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
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      super

      @tags = []
      @rows = []
      @parameters = []

      parse_example(source_lines) if source_lines
    end

    def add_row(row)
      if row.is_a?(Array)
        @rows << Hash[@parameters.zip(row.collect { |value| value.strip })]
      else
        @rows << row
      end
    end

    def remove_row(row)
      if row.is_a?(Array)
        location = @rows.index { |row_hash| row_hash.values_at(*@parameters) == row }
      else
        location = @rows.index { |row_hash| row_hash == row }
      end
      @rows.delete_at(location) if location
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
