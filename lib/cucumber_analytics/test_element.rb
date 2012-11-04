module CucumberAnalytics
  class TestElement < FeatureElement


    attr_reader :steps


    # Creates a new TestElement object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.debug('TestElement#initialize')

      super

      @steps = []
    end

    # Returns true if the two elements have the same steps, minus any keywords
    # and arguments, and false otherwise.
    def ==(other_element)
      steps == other_element.steps
    end


    private


    def parse_test_element_steps(source_lines)
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
