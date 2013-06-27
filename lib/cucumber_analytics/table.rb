module CucumberAnalytics

  # A class modeling the table of a Step.

  class Table

    # The parent object that contains *self*
    attr_accessor :parent_element

    # The contents of the table
    attr_accessor :contents


    # Creates a new Table object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @contents = []

      parsed_table = process_source(source)

      build_table(parsed_table) if parsed_table
    end


    private


    def process_source(source)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      case
        when source.is_a?(String)
          parse_table(source)
        else
          source
      end
    end

    def parse_table(source_text)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      base_file_string = "Feature:\nScenario:\n* step\n"
      source_text = base_file_string + source_text

      parsed_file = Parsing::parse_text(source_text)

      parsed_file.first['elements'].first['steps'].first['rows']
    end

    def build_table(table)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @contents = table.collect { |row| row['cells'] }
    end

  end
end
