module Cucumber
  module Analytics
    class ParsedBackground

      attr_reader :name
      attr_reader :description
      attr_reader :steps

      def initialize
        @name = ''
        @description =[]
        @steps =[]
      end
    end
  end
end
