module Cucumber
  module Analytics
    class ParsedScenario < FeatureElement

      attr_accessor :tags

      def initialize(source_lines = nil)
        super

        @tags = []

        parse_feature_element(source_lines) if source_lines
      end

      def parse_feature_element(source_lines)
        parse_feature_element_tags(source_lines)
        super(source_lines)
        parse_feature_element_steps(source_lines)
      end

    end
  end
end
