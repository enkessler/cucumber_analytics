module CucumberAnalytics
  class ParsedBackground < TestElement


    # Creates a new ParsedBackground object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      super

      parse_background(source_lines) if source_lines
    end


    private


    def parse_background(source_lines)
      parse_feature_element(source_lines)
      parse_test_element_steps(source_lines)
    end

    def parse_feature_element_description(source_lines)
      until source_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* ))/ or
          source_lines.empty?

        @description << source_lines.first.strip
        source_lines.shift
      end
    end

  end
end
