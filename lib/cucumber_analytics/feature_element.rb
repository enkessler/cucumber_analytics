module CucumberAnalytics
  class FeatureElement


    attr_reader :name
    attr_reader :description


    # Creates a new FeatureElement object.
    def initialize(source_lines = nil)
      @name = ''
      @description =[]
    end


    private


    def parse_feature_element(source_lines)
      parse_feature_element_name(source_lines)
      parse_feature_element_description(source_lines)
    end

    #todo - move this elsewhere
    def parse_feature_element_tags(source_lines)
      source_lines.take_while { |line| !(line =~/^\s*(?:[A-Z a-z])+:/) }.tap do |tag_lines|
        tag_lines.join(' ').delete(' ').split('@').each do |tag|
          @tags << "@#{tag.strip}"
        end
      end
      @tags.shift

      while source_lines.first =~ /^\s*@/
        source_lines.shift
      end
    end

    def parse_feature_element_name(source_lines)
      @name.replace source_lines.first.match(/^\s*(?:[A-Z a-z])+:(.*)/)[1].strip
      source_lines.shift
    end

    def parse_feature_element_description(source_lines)
      until source_lines.first =~ /^\s*(?:(?:Given )|(?:When )|(?:Then )|(?:\* ))/ or
          source_lines.first =~ /^\s*\|/ or
          source_lines.empty?

        @description << source_lines.first.strip
        source_lines.shift
      end
    end

  end
end
