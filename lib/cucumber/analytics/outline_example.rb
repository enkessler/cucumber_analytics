module Cucumber
  module Analytics
    class OutlineExample < FeatureElement


      attr_accessor :tags
      attr_accessor :rows


      def initialize(source_lines = nil)
        super

        @tags = []
        @rows = []

        parse_feature_element(source_lines) if source_lines
      end

      def parse_feature_element(source_lines)
        parse_feature_element_tags(source_lines)
        super(source_lines)
        rows.concat source_lines.collect { |line| line.strip }
      end

    end
  end
end
