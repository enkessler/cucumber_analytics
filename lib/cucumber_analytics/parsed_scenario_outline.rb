module CucumberAnalytics
  class ParsedScenarioOutline < TestElement


    attr_accessor :tags
    attr_accessor :examples


    # Creates a new ParsedScenarioOutline object and, if *source_lines* is
    # provided, populates the object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#initialize')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each { |line| CucumberAnalytics::Logging.logger.debug(line.chomp) } if source_lines

      super

      @tags = []
      @examples = []

      parse_outline(source_lines) if source_lines
    end

    # Returns the immediate child elements of the outline (i.e. its example
    # blocks).
    def contains
      @examples
    end

    # Returns tags which have been inherited from the feature level.
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


    def parse_outline(source_lines)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#parse_outline')

      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
      parse_outline_examples(source_lines)
    end

    def parse_feature_element_description(source_lines)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#parse_feature_element_description')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      until source_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* )| (?:Examples: ))/ or
          source_lines.empty?

        unless World.ignored_line?(source_lines.first)
          @description << source_lines.first.strip
        end

        source_lines.shift
      end
    end

    def parse_outline_examples(source_lines)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#parse_outline_examples')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end


      until source_lines.empty?
        example_lines = []

        # collect the tag lines
        until source_lines.first =~ /^\s*Examples:/
          example_lines << source_lines.first
          source_lines.shift
        end

        example_lines << source_lines.first
        source_lines.shift

        # collect the description lines
        until (source_lines.first =~ /^\s*\|/) or source_lines.empty?
          example_lines << source_lines.first
          source_lines.shift
        end

        # collect everything else up to the next example
        until (source_lines.first =~ /^\s*Examples:/) or source_lines.empty?
          example_lines << source_lines.first
          source_lines.shift
        end

        # backtrack in order to not end up stealing the next test's tag lines
        unless source_lines.empty?
          while  (example_lines.last =~ /^\s*@/) or World.ignored_line?(example_lines.last)
            source_lines = [example_lines.pop].concat(source_lines)
          end
        end

        # use the collected lines to create an example
        example = OutlineExample.new(example_lines)
        example.parent_element = self

        @examples << example
      end
    end

  end
end
