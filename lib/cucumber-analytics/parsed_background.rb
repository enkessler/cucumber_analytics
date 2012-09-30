module Cucumber
  module Analytics
    class ParsedBackground < FeatureElement

      def initialize(source_lines = nil)
        super

        parse_feature_element(source_lines) if source_lines
      end

      def parse_feature_element(source_lines)
        super
        parse_feature_element_steps(source_lines)
      end
    end
  end
end
