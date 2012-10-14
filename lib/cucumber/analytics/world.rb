module Cucumber
  module Analytics
    module World


      SANITARY_STRING = '___!!!___'
      STEP_KEYWORD_PATTERN = '\s*(?:Given|When|Then|And|\*)\s*'


      def self.load_step_file(file_path)
        @@defined_expressions = []

        File.open(file_path, 'r') do |file|
          file.readlines.each do |line|
            if step_def_line?(line)
              the_reg_ex = extract_regular_expression(line)
              @@defined_expressions << the_reg_ex
            end
          end
        end
      end

      def self.defined_step_patterns
        @@defined_expressions
      end

      def self.tags_in(container)
        Array.new.tap do |accumulated_tags|
          collect_tags(accumulated_tags, container)
        end
      end

      def self.files_in(container)
        Array.new.tap do |accumulated_files|
          collect_files(accumulated_files, container)
        end
      end

      def self.features_in(container)
        Array.new.tap do |accumulated_features|
          collect_features(accumulated_features, container)
        end
      end

      def self.scenarios_in(container)
        Array.new.tap do |accumulated_scenarios|
          collect_scenarios(accumulated_scenarios, container)
        end
      end

      def self.steps_in(container)
        Array.new.tap do |accumulated_steps|
          collect_steps(accumulated_steps, container)
        end
      end

      def self.undefined_steps_in(container)
        all_steps = steps_in(container)

        all_steps.select { |step| !World.defined_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
      end

      def self.defined_steps_in(container)
        all_steps = steps_in(container)

        all_steps.select { |step| World.defined_step_patterns.any? { |pattern| step.base =~ Regexp.new(pattern) } }
      end


      private


      #Make life easier by ensuring that the only forward slashes in the
      #regular expression are the important ones
      def self.sanitize_line(line)
        line.gsub('\/', SANITARY_STRING)
      end

      #And be sure to restore the line to its original state
      def self.desanitize_line(line)
        line.gsub(SANITARY_STRING, '\/')
      end

      def self.step_def_line?(line)
        !!(sanitize_line(line) =~ /^#{World::STEP_KEYWORD_PATTERN}\/[^\/]*\//)
      end

      def self.extract_regular_expression(line)
        desanitize_line(sanitize_line(line).match(/^#{World::STEP_KEYWORD_PATTERN}\/([^\/]*)\//)[1])
      end

      def self.collect_tags(accumulated_tags, container)
        accumulated_tags.concat container.tags if container.respond_to?(:tags)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_tags(accumulated_tags, child_container)
          end
        end
      end

      def self.collect_files(accumulated_files, container)
        accumulated_files.concat container.feature_files if container.respond_to?(:feature_files)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_files(accumulated_files, child_container)
          end
        end
      end

      def self.collect_features(accumulated_features, container)
        accumulated_features << container.feature if container.respond_to?(:feature)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_features(accumulated_features, child_container)
          end
        end
      end

      def self.collect_scenarios(accumulated_scenarios, container)
        accumulated_scenarios.concat container.scenarios if container.respond_to?(:scenarios)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_scenarios(accumulated_scenarios, child_container)
          end
        end
      end

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
end
