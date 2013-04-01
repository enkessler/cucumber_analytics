module CucumberAnalytics
  class Step


    attr_reader :keyword
    attr_reader :base
    attr_reader :block
    attr_accessor :parent_element
    attr_accessor :arguments


    # Creates a new Step object based on the passed string. If the optional
    # string array is provided, it becomes the block for the step.
    def initialize(step, block = nil)
      CucumberAnalytics::Logging.logger.info('Step#initialize')
      CucumberAnalytics::Logging.logger.debug('Step:')
      CucumberAnalytics::Logging.logger.debug(step.to_yaml)


      @base = step['name']
      @block = parse_block(step)
      @keyword = step['keyword'].strip
      scan_arguments if World.left_delimiter || World.right_delimiter
    end

    # Returns true if the two steps have the same text, minus any keywords
    # and arguments, and false otherwise.
    def ==(other_step)
      left_step = step_text(:with_keywords => false, :with_arguments => false)
      right_step = other_step.step_text(:with_keywords => false, :with_arguments => false)

      left_step == right_step
    end

    # Deprecated
    #
    # Returns the text of the step. Options can be set to selectively exclude
    # certain portions of the text. *left_delimiter* and *right_delimiter* are
    # used to determine which parts of the step are arguments.
    #
    #  a_step = CucumberAnalytics.new('Given *some* step with a block:', ['block line 1', 'block line 2'])
    #
    #  a_step.step_text
    #  #=> ['Given *some* step with a block:', 'block line 1', 'block line 2']
    #  a_step.step_text(:with_keywords => false)
    #  #=> ['*some* step with a block:', 'block line 1', 'block line 2']
    #  a_step.step_text(:with_arguments => false, :left_delimiter => '*', :right_delimiter => '*')
    #  #=> ['Given ** step with a block:']
    #  a_step.step_text(:with_keywords => false, :with_arguments => false, :left_delimiter => '-', :right_delimiter => '-'))
    #  #=> ['*some* step with a block:']
    #
    def step_text(options = {})
      options = {:with_keywords => true,
                 :with_arguments => true,
                 :left_delimiter => World.left_delimiter,
                 :right_delimiter => World.right_delimiter}.merge(options)

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

    def scan_arguments(left_delimiter = World.left_delimiter, right_delimiter  = World.right_delimiter)
      pattern = Regexp.new(Regexp.escape(left_delimiter) + '(.*?)' + Regexp.escape(right_delimiter))

      @arguments = @base.scan(pattern).flatten
    end


    private


    # Returns the step string minus any arguments based on the given delimiters.
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

    def parse_block(step)
      CucumberAnalytics::Logging.logger.info('Step#parse_block')
      CucumberAnalytics::Logging.logger.debug('Step:')
      CucumberAnalytics::Logging.logger.debug(step.to_yaml)


      #todo - Make these their own objects
      case
        when step['rows']
          @block = step['rows'].collect{|row| row['cells']}
        when step['doc_string']
          @block = []
          @block << "\"\"\" #{step['doc_string']['content_type']}"
          @block.concat(step['doc_string']['value'].split($/))
          @block << "\"\"\""
        else
          @block = nil
      end

#      return block if block.first =~ /\s*"""/
#
#      Array.new.tap do |table|
#        block.each do |line|
#          final_line = sanitize_line(line).split('|')
#          final_line.shift
#          final_line.collect! { |cell_value| cell_value.strip }
#
#          table << final_line
#        end
#      end
    end

#    def sanitize_line(line)
#      line.gsub('\|', World::SANITARY_STRING)
#    end

  end
end
