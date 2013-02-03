module CucumberAnalytics
  class ParsedFile


    attr_reader :feature
    attr_accessor :parent_element


    # Creates a new ParsedFile object and, if *file_parsed* is provided,
    # populates the object.
    def initialize(file_parsed = nil)
      CucumberAnalytics::Logging.logger.info('ParsedFile#initialize')

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

    # Returns the immediate child elements of the feature file(i.e. its
    # feature).
    def contains
      @feature ? [@feature] : []
    end

    # Returns the number of features contained in the file.
    def feature_count
      @feature.nil? ? 0 : 1
    end


    private


    def parse_file(file_parsed)
      CucumberAnalytics::Logging.logger.info('ParsedFile#parse_file')
      CucumberAnalytics::Logging.logger.debug("Parsing file: #{file_parsed}")

      @file = file_parsed

      file_lines = []
      feature_lines = []
      background_lines = []

      File.open(@file, 'r') { |file| file_lines = file.readlines }

      # collect feature tag lines
      until file_lines.first =~ /^s*Feature:/ or
          file_lines.empty?

        feature_lines << file_lines.first
        file_lines.shift
      end

      # collect everything else until the end of the feature section
      until file_lines.first =~ /^\s*(?:@|Background:|Scenario:|(?:Scenario Outline:))/ or
          file_lines.empty?

        feature_lines << file_lines.first
        file_lines.shift
      end

      # create a new feature bases on the collected lines
      if feature_lines.empty?
        @feature = nil
      else
        found_feature = ParsedFeature.new(feature_lines)
        found_feature.parent_element = self

        @feature = found_feature
      end


      if file_lines.first =~ /^\s*Background:/

        # collect the background description lines
        until (file_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* )|@|Scenario:|(?:Scenario Outline:))/) or
            file_lines.empty?

          background_lines << file_lines.first
          file_lines.shift
        end

        # collect everything else up to the first test
        until file_lines.first =~ /^\s*(?:@|Scenario:|(?:Scenario Outline:))/ or
            file_lines.empty?

          if file_lines.first =~ /^\s*"""/
            background_lines.concat(extract_doc_string!(file_lines))
          else
            background_lines << file_lines.first
            file_lines.shift
          end
        end

        # create a new background based on the collected lines
        found_background = ParsedBackground.new(background_lines)
        found_background.parent_element = @feature

        @feature.background = found_background
      end

      parse_tests(file_lines)
    end

    def parse_tests(lines)
      CucumberAnalytics::Logging.logger.info('ParsedFile#parse_tests')
      CucumberAnalytics::Logging.logger.debug('lines')
      lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      until lines.empty?
        # we'll need this in order to figure out whether we are dealing with a
        # scenario or an outline
        current_test_line = lines.index { |line| line =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/ }

        test_lines = []

        # collect the tag lines
        until lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/
          test_lines << lines.first
          lines.shift
        end

        test_lines << lines.first
        lines.shift

        # collect the description lines
        until (lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* )|Scenario:|(?:Scenario Outline:))/) or
            lines.empty?

          test_lines << lines.first
          lines.shift
        end

        # collect everything else up to the next test
        until (lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/) or
            lines.empty?

          if (lines.first =~ /^\s*"""/)
            test_lines.concat(extract_doc_string!(lines))
          else
            test_lines << lines.first
            lines.shift
          end
        end

        # backtrack in order to not end up stealing the next test's tag lines
        unless lines.empty?
          while (test_lines.last =~ /^\s*@/) or World.ignored_line?(test_lines.last)
            lines = [test_lines.pop].concat(lines)
          end
        end

        # use the collected lines to create a scenario or an outline accordingly
        if test_lines[current_test_line] =~ /^\s*Scenario Outline:/
          next_test = ParsedScenarioOutline.new(test_lines)
        else
          next_test = ParsedScenario.new(test_lines)
        end

        next_test.parent_element = @feature
        @feature.tests << next_test
      end
    end

    def extract_doc_string!(lines)
      CucumberAnalytics::Logging.logger.info('ParsedFile#extract_doc_string!')
      CucumberAnalytics::Logging.logger.debug('lines')
      lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

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

  end
end
