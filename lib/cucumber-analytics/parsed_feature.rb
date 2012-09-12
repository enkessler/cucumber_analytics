module Cucumber
  module Analytics
    class ParsedFeature

      attr_reader :tags
      attr_reader :name
      attr_reader :description
      attr_accessor :background
      attr_accessor :scenarios

      def initialize
        @tags = []
        @name = ''
        @description = []
        @scenarios = []
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
        scenario_count + scenarios.select { |scenario| scenario.is_a? ParsedScenarioOutline }.reduce(0){ |sum, outline| sum += outline.examples.count }
      end

    end
  end
end
