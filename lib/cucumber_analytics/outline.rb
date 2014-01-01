module CucumberAnalytics

  # A class modeling a Cucumber Scenario Outline.

  class Outline < TestElement

    include Taggable


    # The Example objects contained by the Outline
    attr_accessor :examples


    # Creates a new Outline object and, if *source* is provided, populates the
    # object.
    def initialize(source = nil)
      parsed_outline = process_source(source)

      super(parsed_outline)

      @tags = []
      @tag_elements = []
      @examples = []

      build_outline(parsed_outline) if parsed_outline
    end

    # Returns the immediate child elements of the outline (i.e. its Example
    # objects.
    def contains
      @examples + @steps
    end

    # Returns a gherkin representation of the outline.
    def to_s
      text = ''

      unless tag_elements.empty?
        tag_text = tag_elements.collect { |tag| tag.name }.join(' ')
        text << tag_text + "\n"
      end

      name_text = 'Scenario Outline:'
      name_text += " #{name}" unless name == ''
      text << name_text

      unless description.empty?
        text << "\n"

        description_lines = description_text.split("\n")
        text << "\n" if description_lines.first =~ /\S/

        text << description_lines.collect { |line| "  #{line}" }.join("\n")
        text << "\n" unless steps.empty? && examples.empty?
      end

      unless steps.empty?
        step_text = steps.collect { |step| step.to_s.split("\n").collect { |line| line.empty? ? "\n" : "\n  #{line}" }.join }.join
        text << step_text
      end

      unless examples.empty?
        example_text = examples.collect { |example| "\n\n#{example.to_s}" }.join
        text << example_text
      end

      text
    end


    private


    def build_outline(parsed_outline)
      populate_element_tags(parsed_outline)
      populate_outline_examples(parsed_outline['examples']) if parsed_outline['examples']
    end

    def populate_outline_examples(parsed_examples)
      parsed_examples.each do |example|
        @examples << build_child_element(Example, example)
      end
    end

  end
end
