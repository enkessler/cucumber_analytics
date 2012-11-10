module CucumberAnalytics
  class OutlineExample < FeatureElement


    attr_accessor :tags
    attr_accessor :rows


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

      parse_example(source_lines) if source_lines
    end


    private


    def parse_example(source_lines)
      CucumberAnalytics::Logging.logger.info('OutlineExample#parse_example')

      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)

      source_lines.delete_if { |line| World.ignored_line?(line)}
      rows.concat source_lines.collect { |line| line.strip }
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
