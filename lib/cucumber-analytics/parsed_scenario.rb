module Cucumber
  module Analytics
    class ParsedScenario

      attr_accessor :name
      attr_accessor :description
      attr_accessor :tags
      attr_accessor :steps

      def initialize
        @description = []
        @tags = []
        @steps = []
      end

    end
  end
end
