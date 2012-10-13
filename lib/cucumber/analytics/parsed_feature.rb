module Cucumber
  module Analytics
    class ParsedFeature


      attr_reader :tags
      attr_reader :name
      attr_reader :description
      attr_accessor :background
      attr_accessor :scenarios


      def initialize(source_lines = nil)
        @tags = []
        @name = ''
        @description = []
        @scenarios = []

        parse_feature(source_lines) if source_lines
      end

      def has_background?
        !@background.nil?
      end

      def scenario_count
        @scenarios.select { |scenario| scenario.is_a? ParsedScenario }.count
      end

      def outline_count
        @scenarios.select { |scenario| scenario.is_a? ParsedScenarioOutline }.count
      end

      def test_count
        scenario_count + scenarios.select { |scenario| scenario.is_a? ParsedScenarioOutline }.reduce(0) { |sum, outline| sum += outline.examples.count }
      end

      def contains
        [@background] + @scenarios
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
