#module CucumberAnalytics
#  class ParsedBackground < TestElement
#
#
#    # Creates a new ParsedBackground object and, if *source_lines* is provided,
#    # populates the object.
#    def initialize(source_lines = nil)
#      CucumberAnalytics::Logging.logger.info('ParsedBackground#initialize')
#
#      super
#
#      parse_background(source_lines) if source_lines
#    end
#
#
#    private
#
#
#    def parse_background(source_lines)
#      CucumberAnalytics::Logging.logger.info('ParsedBackground#parse_background')
#
#      parse_feature_element(source_lines)
#      parse_test_element_steps(source_lines)
#    end
#
#    def parse_feature_element_description(source_lines)
#      CucumberAnalytics::Logging.logger.info('ParsedBackground#parse_feature_element_description')
#      CucumberAnalytics::Logging.logger.debug('source lines')
#      source_lines.each do |line|
#        CucumberAnalytics::Logging.logger.debug(line.chomp)
#      end
#
#      until source_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:And )|(?:\* ))/ or
#          source_lines.empty?
#
#        unless World.ignored_line?(source_lines.first)
#          @description << source_lines.first.strip
#        end
#
#        source_lines.shift
#      end
#    end
#
#  end
#end
