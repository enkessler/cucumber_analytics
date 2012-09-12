module Cucumber
  module Analytics
    class OutlineExample

      attr_accessor :name
      attr_accessor :description
      attr_accessor :tags
      attr_accessor :rows

      def initialize
        @name = ''
        @description = []
        @tags = []
        @rows = []
      end

    end
  end
end
