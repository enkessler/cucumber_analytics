module CucumberAnalytics
  class TestElement < FeatureElement


    attr_reader :steps


    # Creates a new TestElement object.
    def initialize(parsed_test_element = nil)
      CucumberAnalytics::Logging.logger.info('TestElement#initialize')

      super

      @steps = []

      parse_test_element(parsed_test_element) if parsed_test_element
    end

    # Returns true if the two elements have the same steps, minus any keywords
    # and arguments, and false otherwise.
    def ==(other_element)
      steps == other_element.steps
    end


    private


    def parse_test_element(parsed_test_element)
      CucumberAnalytics::Logging.logger.info('TestElement#parse_test_element')
      CucumberAnalytics::Logging.logger.debug('Parsed test element:')
      CucumberAnalytics::Logging.logger.debug(parsed_test_element.to_yaml)

      parse_test_element_steps(parsed_test_element)
    end

    def parse_test_element_steps(parsed_test_element)
      CucumberAnalytics::Logging.logger.info('TestElement#parse_test_element_steps')
      CucumberAnalytics::Logging.logger.debug('Parsed test element:')
      CucumberAnalytics::Logging.logger.debug(parsed_test_element.to_yaml)

      if parsed_test_element['steps']
        parsed_test_element['steps'].each do |step|
          element = Step.new(step)
          element.parent_element = self
          @steps << element
        end
      end
#      CucumberAnalytics::Logging.logger.info('TestElement#parse_test_element_steps')
#      CucumberAnalytics::Logging.logger.debug('source lines')
#      source_lines.each do |line|
#        CucumberAnalytics::Logging.logger.debug(line.chomp)
#      end
#
#      until source_lines.empty? or source_lines.first =~ /^\s*(?:@|Examples:)/
#        line = source_lines.first
#        block = nil
#
#        case
#          when line =~ /^\s*"""/
#            block = extract_doc_block(source_lines)
#            @steps[@steps.size - 1] = Step.new(@steps.last.keyword + ' ' + @steps.last.base, block)
#          when line =~ /^\s*\|/
#            block = extract_table_block(source_lines)
#            @steps[@steps.size - 1] = Step.new(@steps.last.keyword + ' ' + @steps.last.base, block)
#          else
#            unless World.ignored_line?(line)
#              @steps << Step.new(line.strip)
#            end
#
#            source_lines.shift
#        end
#      end
    end

#    def extract_doc_block(source_lines)
#      CucumberAnalytics::Logging.logger.info('TestElement#extract_doc_block')
#      CucumberAnalytics::Logging.logger.debug('source lines')
#      source_lines.each do |line|
#        CucumberAnalytics::Logging.logger.debug(line.chomp)
#      end
#
#      step_block = []
#
#      line = source_lines.first
#      leading_whitespace = line[/^\s*/]
#
#      step_block << line.strip
#      source_lines.shift
#
#      line = source_lines.first
#      until line =~ /^\s*"""/
#
#        leading_whitespace.length.times do
#          line.slice!(0, 1) if line[0] =~ /\s/
#        end
#
#        step_block << line.chomp
#        source_lines.shift
#        line = source_lines.first
#      end
#
#      step_block << line.strip
#      source_lines.shift
#
#      step_block
#    end
#
#    def extract_table_block(source_lines)
#      CucumberAnalytics::Logging.logger.info('TestElement#extract_table_block')
#      CucumberAnalytics::Logging.logger.debug('source lines')
#      source_lines.each do |line|
#        CucumberAnalytics::Logging.logger.debug(line.chomp)
#      end
#
#      step_block = []
#
#      line = source_lines.first
#
#      step_block << line.strip
#      source_lines.shift
#
#      line = source_lines.first
#      while line =~ /^\s*\|/
#        step_block << line.strip
#        source_lines.shift
#        line = source_lines.first
#      end
#
#      step_block
#    end

  end
end
