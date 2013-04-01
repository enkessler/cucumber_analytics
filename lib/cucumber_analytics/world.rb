module CucumberAnalytics
  module World


    SANITARY_STRING = '___SANITIZED_BY_CUCUMBER_ANALYTICS___'
    STEP_KEYWORD_PATTERN = '\s*(?:Given|When|Then|And|But|\*)\s*'


    # Returns the left delimiter, which is used to mark the beginning of a step
    # argument.
    def self.left_delimiter
      @left_delimiter || @right_delimiter
    end

    # Sets the left delimiter that will be used by default when determining
    # step arguments.
    def self.left_delimiter=(new_delimiter)
      @left_delimiter = new_delimiter
    end

    # Returns the right delimiter, which is used to mark the end of a step
    # argument.
    def self.right_delimiter
      @right_delimiter || @left_delimiter
    end

    # Sets the right delimiter that will be used by default when determining
    # step arguments.
    def self.right_delimiter=(new_delimiter)
      @right_delimiter = new_delimiter
    end

    # Loads the step patterns contained in the given file into the World.
    def self.load_step_file(file_path)
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

    # Returns the step patterns that have been loaded into the World.
    def self.defined_step_patterns
      @@defined_expressions
    end

    # Returns all tags found in the passed container.
    def self.tags_in(container)
      Array.new.tap do |accumulated_tags|
        collect_tags(accumulated_tags, container)
      end
    end

    # Returns all directories found in the passed container.
    def self.directories_in(container)
      Array.new.tap do |accumulated_directories|
        collect_directories(accumulated_directories, container)
      end
    end

    # Returns all feature files found in the passed container.
    def self.files_in(container)
      Array.new.tap do |accumulated_files|
        collect_files(accumulated_files, container)
      end
    end

    # Returns all features found in the passed container.
    def self.features_in(container)
      Array.new.tap do |accumulated_features|
        collect_features(accumulated_features, container)
      end
    end

    # Returns all tests found in the passed container.
    def self.tests_in(container)
      Array.new.tap do |accumulated_tests|
        collect_tests(accumulated_tests, container)
      end
    end

    # Returns all steps found in the passed container.
    def self.steps_in(container)
      Array.new.tap do |accumulated_steps|
        collect_steps(accumulated_steps, container)
      end
    end

    # Returns all undefined steps found in the passed container.
    def self.undefined_steps_in(container)
      all_steps = steps_in(container)

      all_steps.select { |step| !World.defined_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
    end

    # Returns all defined steps found in the passed container.
    def self.defined_steps_in(container)
      all_steps = steps_in(container)

      all_steps.select { |step| World.defined_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
    end


    private


    # Make life easier by ensuring that the only forward slashes in the
    # regular expression are the important ones.
    def self.sanitize_line(line)
      line.gsub('\/', SANITARY_STRING)
    end

    # And be sure to restore the line to its original state.
    def self.desanitize_line(line)
      line.gsub(SANITARY_STRING, '\/')
    end

    # Returns whether or not the passed line is a step pattern.
    def self.step_def_line?(line)
      !!(sanitize_line(line) =~ /^#{World::STEP_KEYWORD_PATTERN}\/[^\/]*\//)
    end

    # Returns the regular expression portion of a step pattern line.
    def self.extract_regular_expression(line)
      desanitize_line(sanitize_line(line).match(/^#{World::STEP_KEYWORD_PATTERN}\/([^\/]*)\//)[1])
    end

    # Recursively gathers all tags found in the passed container.
    def self.collect_tags(accumulated_tags, container)
      accumulated_tags.concat container.tags if container.respond_to?(:tags)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_tags(accumulated_tags, child_container)
        end
      end
    end

    # Recursively gathers all directories found in the passed container.
    def self.collect_directories(accumulated_directories, container)
      accumulated_directories.concat container.feature_directories if container.respond_to?(:feature_directories)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_directories(accumulated_directories, child_container)
        end
      end
    end

    # Recursively gathers all feature files found in the passed container.
    def self.collect_files(accumulated_files, container)
      accumulated_files.concat container.feature_files if container.respond_to?(:feature_files)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_files(accumulated_files, child_container)
        end
      end
    end

    # Recursively gathers all features found in the passed container.
    def self.collect_features(accumulated_features, container)
      accumulated_features << container.feature if container.respond_to?(:feature) && container.feature

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_features(accumulated_features, child_container)
        end
      end
    end

    # Recursively gathers all tests found in the passed container.
    def self.collect_tests(accumulated_tests, container)
      accumulated_tests.concat container.tests if container.respond_to?(:tests)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_tests(accumulated_tests, child_container)
        end
      end
    end

    # Recursively gathers all steps found in the passed container.
    def self.collect_steps(accumulated_steps, container)
      accumulated_steps.concat container.steps if container.respond_to?(:steps)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_steps(accumulated_steps, child_container)
        end
      end
    end

  end
end
