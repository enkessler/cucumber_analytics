module CucumberAnalytics

  # A class modeling a Cucumber Scenario Outline.

  class Outline < TestElement

    include Taggable


    # The Example objects contained by the Outline
    attr_accessor :examples


    # Creates a new Outline object and, if *source* is provided, populates the
    # object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Outline#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_outline = process_source(source)

      super(parsed_outline)

      @tags = []
      @examples = []

      parse_outline(parsed_outline) if parsed_outline
    end

    # Returns the immediate child elements of the outline (i.e. its Example
    # objects.
    def contains
      CucumberAnalytics::Logging.logger.info('Outline#contains')

      @examples + @steps
    end


    private


    def parse_outline(parsed_outline)
      CucumberAnalytics::Logging.logger.info('Outline#parse_outline')
      CucumberAnalytics::Logging.logger.debug('parsed_outline:')
      CucumberAnalytics::Logging.logger.debug(parsed_outline.to_yaml)


      parse_element_tags(parsed_outline)
      parse_outline_examples(parsed_outline['examples']) if parsed_outline['examples']
    end

    def parse_outline_examples(parsed_examples)
      CucumberAnalytics::Logging.logger.info('Outline#parse_outline_examples')
      CucumberAnalytics::Logging.logger.debug('parsed_examples:')
      CucumberAnalytics::Logging.logger.debug(parsed_examples.to_yaml)


      parsed_examples.each do |example|
        element = Example.new(example)
        element.parent_element = self
        @examples << element
      end
    end

  end
end
