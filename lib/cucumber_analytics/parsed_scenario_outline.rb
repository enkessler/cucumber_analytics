module CucumberAnalytics
  class ParsedScenarioOutline < TestElement


    attr_accessor :tags
    attr_accessor :examples


    def initialize(source_lines = nil)
      super

      @tags = []
      @examples = []

      parse_outline(source_lines) if source_lines
    end

    def contains
      @examples
    end


    private


    def parse_outline(source_lines)
      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
      parse_outline_examples(source_lines)
    end

    def parse_outline_examples(source_lines)
      until source_lines.empty?
        current_example_line = source_lines.index { |line| line =~ /^\s*Examples/ }

        example_lines = source_lines.slice!(0..current_example_line)

        next_example_line = source_lines.index { |line| line =~ /^\s*Examples:/ }

        if next_example_line.nil?
          example_lines.concat(source_lines.slice!(0..source_lines.count))
        else
          while  source_lines[next_example_line - 1] =~ /^\s*@/
            next_example_line -= 1
          end

          example_lines.concat(source_lines.slice!(0...next_example_line))
        end

        @examples << OutlineExample.new(example_lines)
      end
    end

  end
end
