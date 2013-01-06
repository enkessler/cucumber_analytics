module CucumberAnalytics
  class ParsedScenario < TestElement


    attr_accessor :tags
    attr_accessor :parent_element


    # Creates a new ParsedScenario object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#initialize')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
      CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      super

      @tags = []

      parse_scenario(source_lines) if source_lines
    end

    def applied_tags
      additional_tags = @parent_element.tags
      additional_tags.concat(@parent_element.applied_tags) if @parent_element.respond_to?(:applied_tags)

      additional_tags
    end


    private


    def parse_scenario(source_lines)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#parse_scenario')

      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
    end

    def parse_feature_element_description(source_lines)
      CucumberAnalytics::Logging.logger.info('ParsedScenario#parse_feature_element_description')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      until source_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* ))/ or
          source_lines.empty?

        unless World.ignored_line?(source_lines.first)
          @description << source_lines.first.strip
        end

        source_lines.shift
      end
    end

  end
end
