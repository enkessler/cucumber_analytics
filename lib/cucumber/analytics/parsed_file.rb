module Cucumber
  module Analytics
    class ParsedFile


      attr_reader :feature


      def initialize(file_parsed = nil)
        parse_file(file_parsed) if file_parsed
      end

      def name
        File.basename(@file.gsub('\\', '/'))
      end

      def path
        @file
      end

      def contains
        [@feature]
      end


      private


      def parse_file(file_parsed)
        @file = file_parsed

        file_lines = []
        feature_lines = []
        background_lines = []

        File.open(@file, 'r') { |file| file_lines = file.readlines }

        until file_lines.first =~ /^s*Feature:/
          unless ignored_line?(file_lines.first)
            feature_lines << file_lines.first
          end
          file_lines.shift
        end

        until file_lines.first =~ /^\s*(?:@|Background:|Scenario:|(?:Scenario Outline:))/ or file_lines.empty?
          unless ignored_line?(file_lines.first)
            feature_lines << file_lines.first
          end
          file_lines.shift
        end

        until file_lines.first =~ /^\s*(?:@|Scenario:|(?:Scenario Outline:))/ or file_lines.empty?
          if file_lines.first =~ /^\s*"""/
            background_lines.concat(extract_doc_string!(file_lines))
          else
            unless ignored_line?(file_lines.first)
              background_lines << file_lines.first
            end
            file_lines.shift
          end
        end

        @feature = ParsedFeature.new(feature_lines)

        unless background_lines.empty?
          @feature.background = ParsedBackground.new(background_lines)
        end

        parse_tests(file_lines)
      end

      def parse_tests(lines)
        test_lines = []

        until lines.empty?
          current_test_line = lines.index { |line| line =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/ }

          until lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/
            unless ignored_line?(lines.first)
              test_lines << lines.first
            end
            lines.shift
          end

          test_lines << lines.first
          lines.shift

          until (lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/) or lines.empty?
            if (lines.first =~ /^\s*"""/)
              test_lines.concat(extract_doc_string!(lines))
            else
              unless ignored_line?(lines.first)
                test_lines << lines.first
              end
              lines.shift
            end
          end

          unless lines.empty?
            while  (test_lines.last =~ /^\s*@/)
              lines = [test_lines.pop].concat(lines)
            end
          end

          if test_lines[current_test_line] =~ /^\s*Scenario Outline:/
            next_test = ParsedScenarioOutline.new(test_lines)
          else
            next_test = ParsedScenario.new(test_lines)
          end

          @feature.tests << next_test
        end
      end

      def extract_doc_string!(lines)
        doc_block = []

        doc_block << lines.first
        lines.shift

        until lines.first =~ /^\s*"""/
          doc_block << lines.first
          lines.shift
        end

        doc_block << lines.first
        lines.shift

        doc_block
      end

      def ignored_line?(line)
        line =~ /^\s*#/ or !(line =~ /\S/)
      end

    end
  end
end
