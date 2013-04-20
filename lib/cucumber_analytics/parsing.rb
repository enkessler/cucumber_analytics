module CucumberAnalytics
  module Parsing

    class << self

      def parse_text(source_text)
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
