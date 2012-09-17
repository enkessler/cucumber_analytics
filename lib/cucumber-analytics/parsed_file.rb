module Cucumber
  module Analytics
    class ParsedFile

      attr_reader :feature

      def initialize(file_parsed)
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

        until file_lines.first =~ /^\s*(?:@|Background:|Scenario:|(?:Scenario Outline:))/
          unless ignored_line?(file_lines.first)
            feature_lines << file_lines.first
          end
          file_lines.shift
        end

        until file_lines.first =~ /^\s*(?:@|Scenario:|(?:Scenario Outline:))/
          if file_lines.first =~ /^\s*"""/
            background_lines.concat(extract_doc_string!(file_lines))
          else
            unless ignored_line?(file_lines.first)
              background_lines << file_lines.first
            end
            file_lines.shift
          end
        end

        @feature = parse_feature(feature_lines)

        unless background_lines.empty?
          @feature.background = parse_background(background_lines)
        end

        parse_scenarios(file_lines)
      end

      def parse_feature(lines)
        feature = ParsedFeature.new

        lines.take_while { |line| !(line =~/^\s*Feature/) }.tap do |tag_lines|
          tag_lines.join(' ').delete(' ').split('@').each do |tag|
            feature.tags << "@#{tag.strip}"
          end
        end
        feature.tags.shift

        while lines.first =~ /^\s*@/
          lines.shift
        end

        feature.name.replace(lines.first.match(/^\s*Feature:(.*)/)[1].strip)
        lines.shift

        feature.description.concat lines.collect { |line| line.strip }

        feature
      end

      def parse_background(lines)
        background = ParsedBackground.new

        background.name.replace lines.first.match(/^\s*Background:(.*)/)[1].strip
        lines.shift

        until lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:\* ))/
          background.description << lines.first.strip
          lines.shift
        end

        until lines.empty?
          line = lines.first

          if line =~ /^\s*"""/
            leading_whitespace = line[/^\s*/]

            background.steps << line.strip
            lines.shift

            line = lines.first
            until line =~ /^\s*"""/
              leading_whitespace.length.times do |count|
                line.slice!(0, 1) if line[0] =~ /\s/
              end

              background.steps << line.chomp
              lines.shift
              line = lines.first
            end
          end

          background.steps << line.strip
          lines.shift
        end

        background
      end

      def parse_scenario(lines)
        scenario = ParsedScenario.new

        lines.take_while { |line| !(line =~/^\s*Scenario:/) }.tap do |tag_lines|
          tag_lines.join(' ').delete(' ').split('@').each do |tag|
            scenario.tags << "@#{tag.strip}"
          end
        end
        scenario.tags.shift

        while lines.first =~ /^\s*@/
          lines.shift
        end

        scenario.name= lines.first.match(/^\s*Scenario:(.*)/)[1].strip
        lines.shift

        until lines.first =~ /^\s*(?:Given|When|Then|\*)/
          scenario.description << lines.first.strip
          lines.shift
        end

        until lines.empty?
          line = lines.first

          if line =~ /^\s*"""/
            leading_whitespace = line[/^\s*/]

            scenario.steps << line.strip
            lines.shift

            line = lines.first
            until line =~ /^\s*"""/

              leading_whitespace.length.times do |count|
                line.slice!(0, 1) if line[0] =~ /\s/
              end

              scenario.steps << line.chomp
              lines.shift
              line = lines.first
            end
          end

          scenario.steps << line.strip
          lines.shift
        end

        scenario
      end

      def parse_scenario_outline(lines)
        puts 'outline lines to lex:'
        puts lines
        scenario = ParsedScenarioOutline.new

        lines.take_while { |line| !(line =~/^\s*Scenario Outline:/) }.tap do |tag_lines|
          tag_lines.join(' ').delete(' ').split('@').each do |tag|
            scenario.tags << "@#{tag.strip}"
          end
        end
        scenario.tags.shift

        while lines.first =~ /^\s*@/
          lines.shift
        end

        scenario.name = lines.first.match(/^\s*Scenario Outline:(.*)/)[1].strip
        lines.shift

        until lines.first =~ /^\s*(?:Given|When|Then|\*)/
          scenario.description << lines.first.strip
          lines.shift
        end

        until lines.first =~ /^\s*(?:@|Examples:)/
          line = lines.first

          if line =~ /^\s*"""/
            leading_whitespace = line[/^\s*/]

            scenario.steps << line.strip
            lines.shift

            line = lines.first
            until line =~ /^\s*"""/

              leading_whitespace.length.times do |count|
                line.slice!(0, 1) if line[0] =~ /\s/
              end

              scenario.steps << line.chomp
              lines.shift
              line = lines.first
            end
          end

          scenario.steps << line.strip
          lines.shift
        end

        until lines.empty?
          current_example_line = lines.index { |line| line =~ /^\s*Examples/ }

          example_lines = lines.slice!(0..current_example_line)

          next_example_line = lines.index { |line| line =~ /^\s*Examples:/ }

          if next_example_line.nil?
            example_lines.concat(lines.slice!(0..lines.count))
          else
            while  lines[next_example_line - 1] =~ /^\s*@/
              next_example_line -= 1
            end

            example_lines.concat(lines.slice!(0...next_example_line))
          end

          scenario.examples << parse_outline_example(example_lines)
        end

        scenario
      end

      def parse_outline_example(lines)
        example = OutlineExample.new

        lines.take_while { |line| !(line =~/^\s*Examples:/) }.tap do |tag_lines|
          tag_lines.join(' ').delete(' ').split('@').each do |tag|
            example.tags << "@#{tag.strip}"
          end
        end
        example.tags.shift

        while lines.first =~ /^\s*@/
          lines.shift
        end

        example.name= lines.first.match(/^\s*Examples:(.*)/)[1].strip
        lines.shift

        until lines.first =~ /^\s*\|/
          example.description << lines.first.strip
          lines.shift
        end

        example.rows.concat lines.collect { |line| line.strip }

        example
      end

      def parse_scenarios(lines)
        scenario_lines = []

        until lines.empty?
          current_scenario_line = lines.index { |line| line =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/ }

          until lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/
            unless ignored_line?(lines.first)
              scenario_lines << lines.first
            end
            lines.shift
          end

          scenario_lines << lines.first
          lines.shift

          until (lines.first =~ /^\s*(?:Scenario:|(?:Scenario Outline:))/) or lines.empty?
            if (lines.first =~ /^\s*"""/)
              scenario_lines.concat(extract_doc_string!(lines))
            else
              unless ignored_line?(lines.first)
                scenario_lines << lines.first
              end
              lines.shift
            end
          end

          unless lines.empty?
            while  (scenario_lines.last =~ /^\s*@/)
              lines = [scenario_lines.pop].concat(lines)
            end
          end

          if scenario_lines[current_scenario_line] =~ /^\s*Scenario Outline:/
            next_scenario = parse_scenario_outline(scenario_lines)
          else
            next_scenario = parse_scenario(scenario_lines)
          end

          @feature.scenarios << next_scenario
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
