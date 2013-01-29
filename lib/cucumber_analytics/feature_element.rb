module CucumberAnalytics
  class FeatureElement


    attr_reader :name
    attr_reader :description
    attr_accessor :parent_element


    # Creates a new FeatureElement object.
    def initialize(source_lines = nil)
      CucumberAnalytics::Logging.logger.info('FeatureElement#initialize')

      @name = ''
      @description =[]
    end


    private


    def parse_feature_element(source_lines)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element')

      parse_feature_element_name(source_lines)
      parse_feature_element_description(source_lines)
    end

    #todo - move this elsewhere
    def parse_feature_element_tags(source_lines)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_tags')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      source_lines.take_while { |line| line !~ /^\s*(?:[A-Z a-z])+:/ }.tap do |tag_lines|
        tag_lines.delete_if { |line| World.ignored_line?(line)}

        tag_lines.join(' ').delete(' ').split('@').each do |tag|
          @tags << "@#{tag.strip}"
        end
      end
      @tags.shift

      while source_lines.first !~  /^\s*(?:[A-Z a-z])+:/
        source_lines.shift
      end
    end

    def parse_feature_element_name(source_lines)
      CucumberAnalytics::Logging.logger.info('FeatureElement#parse_feature_element_name')
      CucumberAnalytics::Logging.logger.debug('source lines')
      source_lines.each do |line|
        CucumberAnalytics::Logging.logger.debug(line.chomp)
      end

      @name.replace source_lines.first.match(/^\s*(?:[A-Z a-z])+:(.*)/)[1].strip
      source_lines.shift
    end

  end
end
