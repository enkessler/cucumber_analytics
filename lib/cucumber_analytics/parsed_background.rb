module CucumberAnalytics
  class ParsedBackground < TestElement


    # Creates a new ParsedBackground object and, if *source_lines* is provided,
    # populates the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('ParsedBackground#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_background = parse_source(source)

      super(parsed_background)
    end


    private


    def parse_source(source)
      case
        when source.is_a?(String)
          parse_background(source)
        else
          source
      end
    end

    def parse_background(source_text)
      base_file_string = "Feature: Fake feature to parse\n"
      source_text = base_file_string + source_text

      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      parser.parse(source_text, 'fake_file.txt', 0)
      formatter.done
      parsed_file = JSON.parse(io.string)

      parsed_file.first['elements'].first
    end
  end
end
