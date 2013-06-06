require 'stringio'
require 'gherkin/formatter/json_formatter'
require 'gherkin'

module CucumberAnalytics
  module Parsing

    class << self

      def parse_text(source_text)
        CucumberAnalytics::Logging.logger.info('Parsing#parse_text')
        CucumberAnalytics::Logging.logger.debug('source_text:')
        CucumberAnalytics::Logging.logger.debug(source_text)

        raise(ArgumentError, "Cannot parse #{source_text.class} objects. Strings only.") unless source_text.is_a?(String)

        io = StringIO.new
        formatter = Gherkin::Formatter::JSONFormatter.new(io)
        parser = Gherkin::Parser::Parser.new(formatter)
        parser.parse(source_text, 'fake_file.txt', 0)
        formatter.done

        JSON.parse(io.string)
      end

    end

  end
end
