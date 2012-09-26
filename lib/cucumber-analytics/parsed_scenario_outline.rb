module Cucumber
  module Analytics
    class ParsedScenarioOutline

      attr_accessor :name
      attr_accessor :description
      attr_accessor :tags
      attr_accessor :steps
      attr_accessor :examples

      def initialize
        @name = ''
        @description = []
        @tags = []
        @steps = []
        @examples = []
      end

      def stripped_steps(left_delimiter, right_delimiter, keywords_included = false)

        original_left = left_delimiter
        original_right = right_delimiter

        begin
          Regexp.new(left_delimiter)
        rescue RegexpError
          left_delimiter = '\\' + left_delimiter
        end

        begin
          Regexp.new(right_delimiter)
        rescue RegexpError
          right_delimiter = '\\' + right_delimiter
        end

        Array.new.tap do |cleaned_steps|
          steps.each do |step|
            cleaned_steps << step.gsub(Regexp.new("#{left_delimiter}.*?#{right_delimiter}"), original_left + original_right)
          end

          unless keywords_included
            cleaned_steps.map!{ |step| step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '')}
          end
        end
      end


    end
  end
end
