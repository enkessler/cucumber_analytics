module CucumberAnalytics
  class FeatureElement


    attr_reader :name
    attr_reader :description
    attr_reader :steps


    def initialize(source_lines = nil)
      @name = ''
      @description =[]
      @steps =[]
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
        block = nil

        case
          when line =~ /^\s*"""/
            block = extract_doc_block(source_lines)
            @steps[@steps.size - 1] = Step.new(@steps.last.keyword + ' ' + @steps.last.base, block)
          when line =~ /^\s*\|/
            block = extract_table_block(source_lines)
            @steps[@steps.size - 1] = Step.new(@steps.last.keyword + ' ' + @steps.last.base, block)
          else
            @steps << Step.new(line.strip)
            source_lines.shift
        end
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

    def extract_doc_block(source_lines)
      step_block = []

      line = source_lines.first
      leading_whitespace = line[/^\s*/]

      step_block << line.strip
      source_lines.shift

      line = source_lines.first
      until line =~ /^\s*"""/

        leading_whitespace.length.times do
          line.slice!(0, 1) if line[0] =~ /\s/
        end

        step_block << line.chomp
        source_lines.shift
        line = source_lines.first
      end

      step_block << line.strip
      source_lines.shift

      step_block
    end

    def extract_table_block(source_lines)
      step_block = []

      line = source_lines.first

      step_block << line.strip
      source_lines.shift

      line = source_lines.first
      while line =~ /^\s*\|/
        step_block << line.strip
        source_lines.shift
        line = source_lines.first
      end

      step_block
    end

  end
end
