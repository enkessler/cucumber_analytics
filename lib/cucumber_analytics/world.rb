module CucumberAnalytics

# A module providing suite level analysis functionality.

  module World

    # A placeholder string used to mark 'dirty' portions of input strings
    SANITARY_STRING = '___SANITIZED_BY_CUCUMBER_ANALYTICS___'

    # A pattern that matches a Cucumber step keyword
    STEP_DEF_KEYWORD_PATTERN = '(?:Given|When|Then|And|But)'

    # A pattern that matches a 'clean' regular expression
    REGEX_PATTERN_STRING = '\/[^\/]*\/'

    # A pattern that matches a step definition declaration line
    STEP_DEF_LINE_PATTERN = /^\s*#{World::STEP_DEF_KEYWORD_PATTERN}\s*\(?\s*#{REGEX_PATTERN_STRING}\s*\)?/

    # A pattern that captures the regular expression portion of a step definition declaration line
    STEP_DEF_PATTERN_CAPTURE_PATTERN = /^\s*#{World::STEP_DEF_KEYWORD_PATTERN}\s*\(?\s*(#{REGEX_PATTERN_STRING})\s*\)?/


    class << self

      # Returns the left delimiter, which is used to mark the beginning of a step
      # argument.
      def left_delimiter
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        @left_delimiter
      end

      # Sets the left delimiter that will be used by default when determining
      # step arguments.
      def left_delimiter=(new_delimiter)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        @left_delimiter = new_delimiter
      end

      # Returns the right delimiter, which is used to mark the end of a step
      # argument.
      def right_delimiter
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        @right_delimiter
      end

      # Sets the right delimiter that will be used by default when determining
      # step arguments.
      def right_delimiter=(new_delimiter)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        @right_delimiter = new_delimiter
      end

      # Sets the delimiter that will be used by default when determining the
      # boundaries of step arguments.
      def delimiter=(new_delimiter)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        self.left_delimiter = new_delimiter
        self.right_delimiter = new_delimiter
      end

      # Loads the step patterns contained in the given file into the World.
      def load_step_file(file_path)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })


        File.open(file_path, 'r') do |file|
          file.readlines.each do |line|
            if step_def_line?(line)
              the_reg_ex = extract_regular_expression(line)
              loaded_step_patterns << the_reg_ex
            end
          end
        end
      end

      # Loads the step pattern into the World.
      def load_step_pattern(pattern)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        loaded_step_patterns << pattern
      end

      # Returns the step patterns that have been loaded into the World.
      def loaded_step_patterns
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        @defined_expressions ||= []
      end

      # Returns all tags found in the passed container.
      def tags_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        Array.new.tap do |accumulated_tags|
          collect_tags(accumulated_tags, container)
        end
      end

      # Returns all directories found in the passed container.
      def directories_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        Array.new.tap do |accumulated_directories|
          collect_directories(accumulated_directories, container)
        end
      end

      # Returns all feature files found in the passed container.
      def feature_files_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        Array.new.tap do |accumulated_files|
          collect_feature_files(accumulated_files, container)
        end
      end

      # Returns all features found in the passed container.
      def features_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        Array.new.tap do |accumulated_features|
          collect_features(accumulated_features, container)
        end
      end

      # Returns all tests found in the passed container.
      def tests_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        Array.new.tap do |accumulated_tests|
          collect_tests(accumulated_tests, container)
        end
      end

      # Returns all steps found in the passed container.
      def steps_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        Array.new.tap do |accumulated_steps|
          collect_steps(accumulated_steps, container)
        end
      end

      # Returns all undefined steps found in the passed container.
      def undefined_steps_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        all_steps = steps_in(container)

        all_steps.select { |step| !World.loaded_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
      end

      # Returns all defined steps found in the passed container.
      def defined_steps_in(container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        all_steps = steps_in(container)

        all_steps.select { |step| World.loaded_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
      end


      private


      # Make life easier by ensuring that the only forward slashes in the
      # regular expression are the important ones.
      def sanitize_line(line)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        line.gsub('\/', SANITARY_STRING)
      end

      # And be sure to restore the line to its original state.
      def desanitize_line(line)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        line.gsub(SANITARY_STRING, '\/')
      end

      # Returns whether or not the passed line is a step pattern.
      def step_def_line?(line)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        !!(sanitize_line(line) =~ STEP_DEF_LINE_PATTERN)
      end

      # Returns the regular expression portion of a step pattern line.
      def extract_regular_expression(line)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        line = desanitize_line(sanitize_line(line).match(STEP_DEF_PATTERN_CAPTURE_PATTERN)[1])
        line = line.slice(1..(line.length - 2))

        Regexp.new(line)
      end

      # Recursively gathers all tags found in the passed container.
      def collect_tags(accumulated_tags, container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        accumulated_tags.concat container.tags if container.respond_to?(:tags)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_tags(accumulated_tags, child_container)
          end
        end
      end

      # Recursively gathers all directories found in the passed container.
      def collect_directories(accumulated_directories, container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        accumulated_directories.concat container.directories if container.respond_to?(:directories)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_directories(accumulated_directories, child_container)
          end
        end
      end

      # Recursively gathers all feature files found in the passed container.
      def collect_feature_files(accumulated_files, container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        accumulated_files.concat container.feature_files if container.respond_to?(:feature_files)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_feature_files(accumulated_files, child_container)
          end
        end
      end

      # Recursively gathers all features found in the passed container.
      def collect_features(accumulated_features, container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        accumulated_features << container.feature if container.respond_to?(:feature) && container.feature

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_features(accumulated_features, child_container)
          end
        end
      end

      # Recursively gathers all tests found in the passed container.
      def collect_tests(accumulated_tests, container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        accumulated_tests.concat container.tests if container.respond_to?(:tests)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_tests(accumulated_tests, child_container)
          end
        end
      end

      # Recursively gathers all steps found in the passed container.
      def collect_steps(accumulated_steps, container)
        CucumberAnalytics::Logging.log_method("World##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

        accumulated_steps.concat container.steps if container.respond_to?(:steps)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_steps(accumulated_steps, child_container)
          end
        end
      end

    end
  end
end
