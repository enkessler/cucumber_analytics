module Cucumber
  module Analytics
    class ParsedFeature

      attr_accessor :background
      attr_accessor :scenarios

      def initialize
        @scenarios = []
      end

      def has_background?
        !@background.nil?
      end

      def scenario_count
        @scenarios.select { |scenario| scenario.is_a? ParsedScenario }.count
      end

    end
  end
end
