module Cucumber
  module Analytics
    class ParsedScenarioOutline < FeatureElement


      attr_accessor :tags
      attr_accessor :examples


      def initialize(source_lines = nil)
        super

        @tags = []
        @examples = []

        parse_feature_element(source_lines) if source_lines
      end

      def parse_feature_element(source_lines)
        parse_feature_element_tags(source_lines)
        super(source_lines)
        parse_feature_element_steps(source_lines)
        parse_feature_element_examples(source_lines)
      end

      def contains
        @examples
      end

    end
  end
end
