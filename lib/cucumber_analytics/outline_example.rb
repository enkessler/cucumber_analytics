module CucumberAnalytics
  class OutlineExample < FeatureElement


    attr_accessor :tags
    attr_accessor :rows


    # Creates a new OutlineExample object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source_lines = nil)
      super

      @tags = []
      @rows = []

      parse_example(source_lines) if source_lines
    end


    private


    def parse_example(source_lines)
      parse_feature_element_tags(source_lines)
      parse_feature_element(source_lines)
      rows.concat source_lines.collect { |line| line.strip }
    end

  end
end
