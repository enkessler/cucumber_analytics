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

    end
  end
end
