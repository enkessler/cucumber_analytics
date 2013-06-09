module CucumberAnalytics

# A module providing suite level analysis functionality.

  module World

    # A placeholder string used to mark 'dirty' portions of input strings
    SANITARY_STRING = '___SANITIZED_BY_CUCUMBER_ANALYTICS___'

    # A pattern that matches a Cucumber step keyword
    STEP_KEYWORD_PATTERN = '\s*(?:Given|When|Then|And|But|\*)\s*'


    # Returns the left delimiter, which is used to mark the beginning of a step
    # argument.
    def self.left_delimiter
      CucumberAnalytics::Logging.logger.info('World#left_delimiter')

      @left_delimiter
    end

    # Sets the left delimiter that will be used by default when determining
    # step arguments.
    def self.left_delimiter=(new_delimiter)
      CucumberAnalytics::Logging.logger.info('World#left_delimiter=')
      CucumberAnalytics::Logging.logger.debug('new_delimiter:')
      CucumberAnalytics::Logging.logger.debug(new_delimiter)

      @left_delimiter = new_delimiter
    end

    # Returns the right delimiter, which is used to mark the end of a step
    # argument.
    def self.right_delimiter
      CucumberAnalytics::Logging.logger.info('World#right_delimiter')

      @right_delimiter
    end

    # Sets the right delimiter that will be used by default when determining
    # step arguments.
    def self.right_delimiter=(new_delimiter)
      CucumberAnalytics::Logging.logger.info('World#right_delimiter=')
      CucumberAnalytics::Logging.logger.debug('new_delimiter:')
      CucumberAnalytics::Logging.logger.debug(new_delimiter)

      @right_delimiter = new_delimiter
    end

    # Sets the delimiter that will be used by default when determining the
    # boundaries of step arguments.
    def self.delimiter=(new_delimiter)
      CucumberAnalytics::Logging.logger.info('World#delimiter=')
      CucumberAnalytics::Logging.logger.debug('new_delimiter:')
      CucumberAnalytics::Logging.logger.debug(new_delimiter)

      self.left_delimiter = new_delimiter
      self.right_delimiter = new_delimiter
    end

    # Loads the step patterns contained in the given file into the World.
    def self.load_step_file(file_path)
      CucumberAnalytics::Logging.logger.info('World#load_step_file')
      CucumberAnalytics::Logging.logger.debug('file_path:')
      CucumberAnalytics::Logging.logger.debug(file_path)

      @@defined_expressions ||= []

      File.open(file_path, 'r') do |file|
        file.readlines.each do |line|
          if step_def_line?(line)
            the_reg_ex = extract_regular_expression(line)
            @@defined_expressions << the_reg_ex
          end
        end
      end
    end

    # Loads the step pattern into the World.
    def self.load_step_pattern(pattern)
      CucumberAnalytics::Logging.logger.info('World#load_step_pattern')
      CucumberAnalytics::Logging.logger.debug('pattern:')
      CucumberAnalytics::Logging.logger.debug(pattern)

      @@defined_expressions ||= []
      @@defined_expressions << pattern
    end

    # Returns the step patterns that have been loaded into the World.
    def self.loaded_step_patterns
      CucumberAnalytics::Logging.logger.info('World#loaded_step_patterns')

      @@defined_expressions ||= []
    end

    # Returns all tags found in the passed container.
    def self.tags_in(container)
      CucumberAnalytics::Logging.logger.info('World#tags_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      Array.new.tap do |accumulated_tags|
        collect_tags(accumulated_tags, container)
      end
    end

    # Returns all directories found in the passed container.
    def self.directories_in(container)
      CucumberAnalytics::Logging.logger.info('World#directories_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      Array.new.tap do |accumulated_directories|
        collect_directories(accumulated_directories, container)
      end
    end

    # Returns all feature files found in the passed container.
    def self.feature_files_in(container)
      CucumberAnalytics::Logging.logger.info('World#feature_files_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      Array.new.tap do |accumulated_files|
        collect_feature_files(accumulated_files, container)
      end
    end

    # Returns all features found in the passed container.
    def self.features_in(container)
      CucumberAnalytics::Logging.logger.info('World#features_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      Array.new.tap do |accumulated_features|
        collect_features(accumulated_features, container)
      end
    end

    # Returns all tests found in the passed container.
    def self.tests_in(container)
      CucumberAnalytics::Logging.logger.info('World#tests_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      Array.new.tap do |accumulated_tests|
        collect_tests(accumulated_tests, container)
      end
    end

    # Returns all steps found in the passed container.
    def self.steps_in(container)
      CucumberAnalytics::Logging.logger.info('World#steps_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      Array.new.tap do |accumulated_steps|
        collect_steps(accumulated_steps, container)
      end
    end

    # Returns all undefined steps found in the passed container.
    def self.undefined_steps_in(container)
      CucumberAnalytics::Logging.logger.info('World#undefined_steps_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      all_steps = steps_in(container)

      all_steps.select { |step| !World.loaded_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
    end

    # Returns all defined steps found in the passed container.
    def self.defined_steps_in(container)
      CucumberAnalytics::Logging.logger.info('World#defined_steps_in')
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      all_steps = steps_in(container)

      all_steps.select { |step| World.loaded_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
    end


    private


    # Make life easier by ensuring that the only forward slashes in the
    # regular expression are the important ones.
    def self.sanitize_line(line)
      CucumberAnalytics::Logging.logger.info('World#sanitize_line')
      CucumberAnalytics::Logging.logger.debug('line:')
      CucumberAnalytics::Logging.logger.debug(line)

      line.gsub('\/', SANITARY_STRING)
    end

    # And be sure to restore the line to its original state.
    def self.desanitize_line(line)
      CucumberAnalytics::Logging.logger.info('World#desanitize_line')
      CucumberAnalytics::Logging.logger.debug('line:')
      CucumberAnalytics::Logging.logger.debug(line)

      line.gsub(SANITARY_STRING, '\/')
    end

    # Returns whether or not the passed line is a step pattern.
    def self.step_def_line?(line)
      CucumberAnalytics::Logging.logger.info('World#step_def_line?')
      CucumberAnalytics::Logging.logger.debug('line:')
      CucumberAnalytics::Logging.logger.debug(line)

      !!(sanitize_line(line) =~ /^#{World::STEP_KEYWORD_PATTERN}\/[^\/]*\//)
    end

    # Returns the regular expression portion of a step pattern line.
    def self.extract_regular_expression(line)
      CucumberAnalytics::Logging.logger.info('World#extract_regular_expression')
      CucumberAnalytics::Logging.logger.debug('line:')
      CucumberAnalytics::Logging.logger.debug(line)

      line = desanitize_line(sanitize_line(line).match(/^#{World::STEP_KEYWORD_PATTERN}\/([^\/]*)\//)[1])
      Regexp.new(line)
    end

    # Recursively gathers all tags found in the passed container.
    def self.collect_tags(accumulated_tags, container)
      CucumberAnalytics::Logging.logger.info('World#collect_tags')
      CucumberAnalytics::Logging.logger.debug('accumulated_tags:')
      CucumberAnalytics::Logging.logger.debug(accumulated_tags)
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      accumulated_tags.concat container.tags if container.respond_to?(:tags)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_tags(accumulated_tags, child_container)
        end
      end
    end

    # Recursively gathers all directories found in the passed container.
    def self.collect_directories(accumulated_directories, container)
      CucumberAnalytics::Logging.logger.info('World#collect_directories')
      CucumberAnalytics::Logging.logger.debug('accumulated_directories:')
      CucumberAnalytics::Logging.logger.debug(accumulated_directories)
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      accumulated_directories.concat container.directories if container.respond_to?(:directories)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_directories(accumulated_directories, child_container)
        end
      end
    end

    # Recursively gathers all feature files found in the passed container.
    def self.collect_feature_files(accumulated_files, container)
      CucumberAnalytics::Logging.logger.info('World#collect_feature_files')
      CucumberAnalytics::Logging.logger.debug('accumulated_files:')
      CucumberAnalytics::Logging.logger.debug(accumulated_files)
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      accumulated_files.concat container.feature_files if container.respond_to?(:feature_files)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_feature_files(accumulated_files, child_container)
        end
      end
    end

    # Recursively gathers all features found in the passed container.
    def self.collect_features(accumulated_features, container)
      CucumberAnalytics::Logging.logger.info('World#collect_features')
      CucumberAnalytics::Logging.logger.debug('accumulated_features:')
      CucumberAnalytics::Logging.logger.debug(accumulated_features)
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      accumulated_features << container.feature if container.respond_to?(:feature) && container.feature

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_features(accumulated_features, child_container)
        end
      end
    end

    # Recursively gathers all tests found in the passed container.
    def self.collect_tests(accumulated_tests, container)
      CucumberAnalytics::Logging.logger.info('World#collect_tests')
      CucumberAnalytics::Logging.logger.debug('accumulated_tests:')
      CucumberAnalytics::Logging.logger.debug(accumulated_tests)
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      accumulated_tests.concat container.tests if container.respond_to?(:tests)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_tests(accumulated_tests, child_container)
        end
      end
    end

    # Recursively gathers all steps found in the passed container.
    def self.collect_steps(accumulated_steps, container)
      CucumberAnalytics::Logging.logger.info('World#collect_steps')
      CucumberAnalytics::Logging.logger.debug('accumulated_steps:')
      CucumberAnalytics::Logging.logger.debug(accumulated_steps)
      CucumberAnalytics::Logging.logger.debug('container:')
      CucumberAnalytics::Logging.logger.debug(container)

      accumulated_steps.concat container.steps if container.respond_to?(:steps)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_steps(accumulated_steps, child_container)
        end
      end
    end

  end
end
