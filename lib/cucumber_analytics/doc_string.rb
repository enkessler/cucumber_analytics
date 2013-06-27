module CucumberAnalytics

  # A class modeling the Doc String of a Step.

  class DocString

    # The parent object that contains *self*
    attr_accessor :parent_element

    # The content type associated with the doc string
    attr_accessor :content_type

    # The contents of the doc string
    attr_accessor :contents


    # Creates a new DocString object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @contents = []

      parsed_doc_string = process_source(source)

      build_doc_string(parsed_doc_string) if parsed_doc_string
    end


    private


    def process_source(source)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      case
        when source.is_a?(String)
          parse_doc_string(source)
        else
          source
      end
    end

    def parse_doc_string(source_text)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      base_file_string = "Feature:\nScenario:\n* step\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first['elements'].first['steps'].first['doc_string']
    end

    def build_doc_string(doc_string)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @content_type = doc_string['content_type'] == "" ? nil : doc_string['content_type']
      @contents = doc_string['value'].split($/)
    end

  end
end
