module Cucumber
  module Analytics
    class Step

      attr_reader :keyword
      attr_reader :base
      attr_reader :block


      def initialize(step, block = nil)
        @base = step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '')
        @block = block
        @keyword = step.slice(/#{World::STEP_KEYWORD_PATTERN}/).strip
      end

      def step_text(options = {})
        options = {with_keywords: true,
                   with_arguments: true,
                   left_delimiter: World.left_delimiter,
                   right_delimiter: World.right_delimiter}.merge(options)

        final_step = []
        step_text = ''

        step_text += "#{@keyword} " if options[:with_keywords]

        if options[:with_arguments]
          step_text += @base
          final_step << step_text
          final_step.concat @block if @block
        else
          step_text += stripped_step(@base, options[:left_delimiter], options[:right_delimiter])
          final_step << step_text
        end

        final_step
      end


      private


      def stripped_step(step, left_delimiter, right_delimiter)
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

        step.gsub(Regexp.new("#{left_delimiter}.*?#{right_delimiter}"), original_left + original_right)
      end

    end
  end
end
