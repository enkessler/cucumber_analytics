module CucumberAnalytics
  class Step


    attr_accessor :keyword
    attr_accessor :base
    attr_accessor :block
    attr_accessor :parent_element
    attr_accessor :arguments


    # Creates a new Step object based on the passed string. If the optional
    # string array is provided, it becomes the block for the step.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Step#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      @arguments = []

      parsed_step = process_source(source)

      build_step(parsed_step) if parsed_step
    end

    def delimiter=(new_delimiter)
      CucumberAnalytics::Logging.logger.info('Step#delimiter=')
      CucumberAnalytics::Logging.logger.debug('new_delimiter:')
      CucumberAnalytics::Logging.logger.debug(new_delimiter)

      self.left_delimiter = new_delimiter
      self.right_delimiter = new_delimiter
    end

    # Returns the left delimiter, which is used to mark the beginning of a step
    # argument.
    def left_delimiter
      CucumberAnalytics::Logging.logger.info('Step#left_delimiter')

      @left_delimiter || World.left_delimiter
    end

    # Sets the left delimiter that will be used by default when determining
    # step arguments.
    def left_delimiter=(new_delimiter)
      CucumberAnalytics::Logging.logger.info('Step#left_delimiter=')
      CucumberAnalytics::Logging.logger.debug('new_delimiter:')
      CucumberAnalytics::Logging.logger.debug(new_delimiter)

      @left_delimiter = new_delimiter
    end

    # Returns the right delimiter, which is used to mark the end of a step
    # argument.
    def right_delimiter
      CucumberAnalytics::Logging.logger.info('Step#right_delimiter')

      @right_delimiter || World.right_delimiter
    end

    # Sets the right delimiter that will be used by default when determining
    # step arguments.
    def right_delimiter=(new_delimiter)
      CucumberAnalytics::Logging.logger.info('Step#right_delimiter=')
      CucumberAnalytics::Logging.logger.debug('new_delimiter:')
      CucumberAnalytics::Logging.logger.debug(new_delimiter)

      @right_delimiter = new_delimiter
    end

    # Returns true if the two steps have the same text, minus any keywords
    # and arguments, and false otherwise.
    def ==(other_step)
      CucumberAnalytics::Logging.logger.info('Step#==')
      CucumberAnalytics::Logging.logger.debug('other_step:')
      CucumberAnalytics::Logging.logger.debug(other_step)

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
      CucumberAnalytics::Logging.logger.info('Step#step_text')
      CucumberAnalytics::Logging.logger.debug('options:')
      CucumberAnalytics::Logging.logger.debug(options)

      options = {:with_keywords => true,
                 :with_arguments => true,
                 :left_delimiter => self.left_delimiter,
                 :right_delimiter => self.right_delimiter}.merge(options)

      final_step = []
      step_text = ''

      step_text += "#{@keyword} " if options[:with_keywords]

      if options[:with_arguments]
        step_text += @base
        final_step << step_text
        final_step.concat(rebuild_block_text(@block)) if @block
      else
        step_text += stripped_step(@base, options[:left_delimiter], options[:right_delimiter])
        final_step << step_text
      end

      final_step
    end

    def scan_arguments(*how)
      CucumberAnalytics::Logging.logger.info('Step#scan_arguments')
      CucumberAnalytics::Logging.logger.debug('how:')
      CucumberAnalytics::Logging.logger.debug(how)

      if how.count == 1
        pattern = how.first
      else
        left_delimiter = how[0] || self.left_delimiter
        right_delimiter = how[1] || self.right_delimiter

        return [] unless left_delimiter && right_delimiter

        pattern = Regexp.new(Regexp.escape(left_delimiter) + '(.*?)' + Regexp.escape(right_delimiter))
      end

      @arguments = @base.scan(pattern).flatten
    end


    private


    def process_source(source)
      CucumberAnalytics::Logging.logger.info('Step#process_source')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      case
        when source.is_a?(String)
          parse_step(source)
        else
          source
      end
    end

    def parse_step(source_text)
      CucumberAnalytics::Logging.logger.info('Step#parse_step')
      CucumberAnalytics::Logging.logger.debug('source_text:')
      CucumberAnalytics::Logging.logger.debug(source_text)

      base_file_string = "Feature: Fake feature to parse\nScenario:\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first['elements'].first['steps'].first
    end

    def build_step(step)
      CucumberAnalytics::Logging.logger.info('Step#build_step')
      CucumberAnalytics::Logging.logger.debug('step:')
      CucumberAnalytics::Logging.logger.debug(step.to_yaml)

      @base = step['name']
      @block = parse_block(step)
      @keyword = step['keyword'].strip
      scan_arguments
    end

    # Returns the step string minus any arguments based on the given delimiters.
    def stripped_step(step, left_delimiter, right_delimiter)
      CucumberAnalytics::Logging.logger.info('Step#stripped_step')
      CucumberAnalytics::Logging.logger.debug('step:')
      CucumberAnalytics::Logging.logger.debug(step)
      CucumberAnalytics::Logging.logger.debug('left_delimiter:')
      CucumberAnalytics::Logging.logger.debug(left_delimiter)
      CucumberAnalytics::Logging.logger.debug('right_delimiter:')
      CucumberAnalytics::Logging.logger.debug(right_delimiter)

      unless left_delimiter.nil? || right_delimiter.nil?
        pattern = Regexp.new(Regexp.escape(left_delimiter) + '.*?' + Regexp.escape(right_delimiter))

        step = step.gsub(pattern, left_delimiter + right_delimiter)
      end

      step
    end

    def parse_block(step)
      CucumberAnalytics::Logging.logger.info('Step#parse_block')
      CucumberAnalytics::Logging.logger.debug('step:')
      CucumberAnalytics::Logging.logger.debug(step.to_yaml)


      #todo - Make these their own objects
      case
        when step['rows']
          @block = step['rows'].collect { |row| row['cells'] }
        when step['doc_string']
          @block = []
          @block << "\"\"\" #{step['doc_string']['content_type']}"
          @block.concat(step['doc_string']['value'].split($/))
          @block << "\"\"\""
        else
          @block = nil
      end

      @block
    end

    def rebuild_block_text(blok)
      CucumberAnalytics::Logging.logger.info('Step#rebuild_block_text')
      CucumberAnalytics::Logging.logger.debug('blok:')
      CucumberAnalytics::Logging.logger.debug(blok)

      blok.collect { |row| "|#{row.join('|')}|" }
    end

  end
end
