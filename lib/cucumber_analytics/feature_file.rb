module CucumberAnalytics

  # A class modeling a Cucumber .feature file.

  class FeatureFile

    include Containing


    # The Feature objects contained by the FeatureFile
    attr_accessor :features

    # The parent object that contains *self*
    attr_accessor :parent_element


    # Creates a new FeatureFile object and, if *file_parsed* is provided,
    # populates the object.
    def initialize(file = nil)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @file = file
      @features = []

      if file
        raise(ArgumentError, "Unknown file: #{file.inspect}") unless File.exists?(file)

        parsed_file = parse_file(file)

        build_file(parsed_file)
      end
    end

    # Returns the name of the file.
    def name
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}")

      File.basename(@file.gsub('\\', '/'))
    end

    # Returns the path of the file.
    def path
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}")

      @file
    end

    # Returns the immediate child elements of the file(i.e. its Feature object).
    def contains
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}")

      @features
    end

    # Returns the number of features contained in the file.
    def feature_count
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}")

      @features.count
    end

    # Returns the Feature object contained by the FeatureFile.
    def feature
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}")

      @features.first
    end

    private


    def parse_file(file_to_parse)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      source_text = IO.read(file_to_parse)

      Parsing::parse_text(source_text)
    end

    def build_file(parsed_file)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      unless parsed_file.empty?
        @features << build_child_element(Feature, parsed_file.first)
      end
    end

  end
end
