module Cucumber
  module Analytics
    class ParsedFeature


      attr_reader :tags
      attr_reader :name
      attr_reader :description
      attr_accessor :background
      attr_accessor :tests


      def initialize(source_lines = nil)
        @tags = []
        @name = ''
        @description = []
        @tests = []

        parse_feature(source_lines) if source_lines
      end

      def has_background?
        !@background.nil?
      end

      def scenarios
        @tests.select { |test| test.is_a? ParsedScenario }
      end

      def outlines
        @tests.select { |test| test.is_a? ParsedScenarioOutline }
      end

      def scenario_count
        scenarios.count
      end

      def outline_count
        outlines.count
      end

      def test_count
        @tests.count
      end

      def test_case_count
        scenario_count + outlines.reduce(0) { |sum, outline| sum += outline.examples.count }
      end

      def contains
        [@background] + @tests
      end


      private


      def parse_feature(source_lines)
        source_lines.take_while { |line| !(line =~/^\s*Feature/) }.tap do |tag_lines|
          tag_lines.join(' ').delete(' ').split('@').each do |tag|
            tags << "@#{tag.strip}"
          end
        end
        tags.shift

        while source_lines.first =~ /^\s*@/
          source_lines.shift
        end

        name.replace(source_lines.first.match(/^\s*Feature:(.*)/)[1].strip)
        source_lines.shift

        description.concat source_lines.collect { |line| line.strip }
      end

    end
  end
end
