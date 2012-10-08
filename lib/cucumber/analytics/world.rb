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

      def self.steps_in(container, include_keywords = true)
        Array.new.tap do |accumulated_steps|
          collect_steps(accumulated_steps, container, include_keywords)
        end
      end

      def self.undefined_steps_in(container, include_keywords = true)
        all_steps = steps_in(container, include_keywords)

        all_steps.delete_if { |step| World.defined_step_patterns.any? { |pattern| step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '') =~ Regexp.new(pattern) } }
      end

      def self.defined_steps_in(container, include_keywords = true)
        all_steps = steps_in(container, include_keywords)

        all_steps.keep_if { |step| World.defined_step_patterns.any? { |pattern| step.sub(/#{World::STEP_KEYWORD_PATTERN}/, '') =~ Regexp.new(pattern) } }
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

      def self.collect_steps(accumulated_steps, container, include_keywords = true)
        accumulated_steps.concat container.steps(include_keywords) if container.respond_to?(:steps)

        if container.respond_to?(:contains)
          container.contains.each do |child_container|
            collect_steps(accumulated_steps, child_container, include_keywords)
          end
        end
      end

    end
  end
end
