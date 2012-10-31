module CucumberAnalytics
  class ParsedFile


    attr_reader :feature


    # Creates a new ParsedFile object and, if *file_parsed* is provided,
    # populates the object.
    def initialize(file_parsed = nil)
      CucumberAnalytics::Logging.logger.debug('ParsedFile#initialize')

      parse_file(file_parsed) if file_parsed
    end

    # Returns the name of the file.
    def name
      File.basename(@file.gsub('\\', '/'))
    end

    # Returns the path of the file.
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

      # collect feature tag lines
      until file_lines.first =~ /^s*Feature:/
        unless ignored_line?(file_lines.first)
          feature_lines << file_lines.first
        end
        file_lines.shift
      end

      # collect everything else until the end of the feature section
      until file_lines.first =~ /^\s*(?:@|Background:|Scenario:|(?:Scenario Outline:))/ or file_lines.empty?
        unless ignored_line?(file_lines.first)
          feature_lines << file_lines.first
        end
        file_lines.shift
      end

      if file_lines.first =~ /^\s*Background:/

        # collect the background description lines
        until (file_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* )|@|Scenario:|(?:Scenario Outline:))/) or file_lines.empty?
          unless ignored_line?(file_lines.first)
            background_lines << file_lines.first
          end
          file_lines.shift
        end

        # collect everything else up to the first test
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
        # we'll need this in order to figure out whether we are dealing with a
        # scenario or an outline
        current_test_line = lines.index { |line| line =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/ }

        # collect the tag lines
        until lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/
          unless ignored_line?(lines.first)
            test_lines << lines.first
          end
          lines.shift
        end

        test_lines << lines.first
        lines.shift

        # collect the description lines
        until (lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* )|Scenario:|(?:Scenario Outline:))/) or lines.empty?
          unless ignored_line?(lines.first)
            test_lines << lines.first
          end
          lines.shift
        end

        # collect everything else up to the next test
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

        # backtrack in order to not end up stealing the next test's tag lines
        unless lines.empty?
          while  (test_lines.last =~ /^\s*@/)
            lines = [test_lines.pop].concat(lines)
          end
        end

        # use the collected lines to create a scenario or an outline accordingly
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
