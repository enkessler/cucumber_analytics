module CucumberAnalytics
  class ParsedScenarioOutline < TestElement


    attr_accessor :tags
    attr_accessor :examples


    # Creates a new ParsedScenarioOutline object and, if *source* is
    # provided, populates the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source.to_yaml)

      parsed_outline = process_source(source)

      super(parsed_outline)

      @tags = []
      @examples = []

      parse_outline(parsed_outline) if parsed_outline
    end

    # Returns the immediate child elements of the outline (i.e. its example
    # blocks).
    def contains
      @examples + @steps
    end

    # Returns tags which are applicable to the outline which have been
    # inherited from the feature level.
    def applied_tags
      @parent_element.all_tags
    end

    # Returns all tags which are applicable to the scenario outline.
    def all_tags
      applied_tags + @tags
    end


    private


    def parse_outline(parsed_outline)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#parse_outline')
      CucumberAnalytics::Logging.logger.debug('Parsed outline:')
      CucumberAnalytics::Logging.logger.debug(parsed_outline.to_yaml)


      parse_feature_element_tags(parsed_outline)
      parse_outline_examples(parsed_outline['examples']) if parsed_outline['examples']
    end

    def parse_outline_examples(parsed_examples)
      CucumberAnalytics::Logging.logger.info('ParsedScenarioOutline#parse_outline_examples')
      CucumberAnalytics::Logging.logger.debug('Parsed examples:')
      CucumberAnalytics::Logging.logger.debug(parsed_examples.to_yaml)


      parsed_examples.each do |example|
        element = OutlineExample.new(example)
        element.parent_element = self
        @examples << element
      end
    end

  end
end
