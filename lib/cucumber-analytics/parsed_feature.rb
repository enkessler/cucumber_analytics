module Cucumber
  module Analytics
    class ParsedFeature

      attr_accessor :background

      def has_background?
        !@background.nil?
      end

    end
  end
end
