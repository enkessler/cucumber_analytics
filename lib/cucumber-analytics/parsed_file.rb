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
        file_lines.delete_if { |line| line =~ /^\s*#/ }
        file_lines.delete_if { |line| !(line =~ /\S/) }

        feature_start_line = file_lines.index { |line| line =~ /^s*Feature:/ }
        feature_lines.concat(file_lines.slice!(0..feature_start_line))

        feature_end_line = file_lines.index { |line| line =~ /^\s*(?:@|Background:|Scenario:|(?:Scenario Outline:))/ }
        feature_lines.concat(file_lines.slice!(0...feature_end_line))

        background_end_line = file_lines.index { |line| line =~ /^\s*(?:@|Scenario:|(?:Scenario Outline:))/ }
        background_lines.concat(file_lines.slice!(0...background_end_line))

        @feature = parse_feature(feature_lines)

        unless background_lines.empty?
          @feature.background = parse_background(background_lines)
        end
      end

      def parse_feature(lines)
        feature = ParsedFeature.new

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

        background.steps.concat lines.collect { |line| line.strip }

        background
      end

    end
  end
end
