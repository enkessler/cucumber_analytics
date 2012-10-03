module Cucumber
  module Analytics
    class FeatureElement

      attr_reader :name
      attr_reader :description

      def initialize(source_lines = nil)
        @name = ''
        @description =[]
        @steps =[]
      end

      def steps(include_keywords = false)
        include_keywords ? @steps : @steps.map { |step| step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '') }
      end

      def stripped_steps(left_delimiter, right_delimiter, include_keywords = false)
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
          steps(include_keywords).each do |step|
            cleaned_steps << step.gsub(Regexp.new("#{left_delimiter}.*?#{right_delimiter}"), original_left + original_right)
          end
        end
      end

      def defined_steps(include_keywords = false)
        steps(include_keywords).keep_if { |step| World.defined_step_patterns.any? { |pattern| step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '') =~ Regexp.new(pattern) } }
      end

      def undefined_steps(include_keywords = false)
        steps(include_keywords).delete_if { |step| World.defined_step_patterns.any? { |pattern| step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '') =~ Regexp.new(pattern) } }
      end


      private


      def parse_feature_element(source_lines)
        parse_feature_element_name(source_lines)
        parse_feature_element_description(source_lines)
      end

      def parse_feature_element_tags(source_lines)
        source_lines.take_while { |line| !(line =~/^\s*(?:[A-Z a-z])+:/) }.tap do |tag_lines|
          tag_lines.join(' ').delete(' ').split('@').each do |tag|
            @tags << "@#{tag.strip}"
          end
        end
        @tags.shift

        while source_lines.first =~ /^\s*@/
          source_lines.shift
        end
      end

      def parse_feature_element_name(source_lines)
        @name.replace source_lines.first.match(/^\s*(?:[A-Z a-z])+:(.*)/)[1].strip
        source_lines.shift
      end

      def parse_feature_element_description(source_lines)
        until source_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:\* ))/ or
            source_lines.first =~ /^\s*\|/ or
            source_lines.empty?

          @description << source_lines.first.strip
          source_lines.shift
        end
      end

      def parse_feature_element_steps(source_lines)
        until source_lines.empty? or source_lines.first =~ /^\s*(?:@|Examples:)/
          line = source_lines.first

          if line =~ /^\s*"""/
            leading_whitespace = line[/^\s*/]

            @steps << line.strip
            source_lines.shift

            line = source_lines.first
            until line =~ /^\s*"""/

              leading_whitespace.length.times do |count|
                line.slice!(0, 1) if line[0] =~ /\s/
              end

              @steps << line.chomp
              source_lines.shift
              line = source_lines.first
            end
          end

          @steps << line.strip
          source_lines.shift
        end
      end

      def parse_feature_element_examples(source_lines)
        until source_lines.empty?
          current_example_line = source_lines.index { |line| line =~ /^\s*Examples/ }

          example_lines = source_lines.slice!(0..current_example_line)

          next_example_line = source_lines.index { |line| line =~ /^\s*Examples:/ }

          if next_example_line.nil?
            example_lines.concat(source_lines.slice!(0..source_lines.count))
          else
            while  source_lines[next_example_line - 1] =~ /^\s*@/
              next_example_line -= 1
            end

            example_lines.concat(source_lines.slice!(0...next_example_line))
          end

          @examples << OutlineExample.new(example_lines)
        end
      end

    end
  end
end
