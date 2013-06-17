module CucumberAnalytics

  # A class modeling a directory containing .feature files.

  class Directory

    # The FeatureFile objects contained by the Directory
    attr_accessor :feature_files

    # The Directory objects contained by the Directory
    attr_accessor :directories

    # The parent object that contains *self*
    attr_accessor :parent_element


    # Creates a new Directory object and, if *directory_parsed* is provided,
    # populates the object.
    def initialize(directory_parsed = nil)
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @directory = directory_parsed

      @feature_files = []
      @directories = []

      if directory_parsed
        raise(ArgumentError, "Unknown directory: #{directory_parsed.inspect}") unless File.exists?(directory_parsed)
        scan_directory
      end
    end

    # Returns the name of the directory.
    def name
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      File.basename(@directory.gsub('\\', '/'))
    end

    # Returns the path of the directory.
    def path
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @directory
    end

    # Returns the number of sub-directories contained in the directory.
    def directory_count
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @directories.count
    end

    # Returns the number of features files contained in the directory.
    def feature_file_count
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @feature_files.count
    end

    # Returns the immediate child elements of the directory (i.e. its Directory
    # and FeatureFile objects).
    def contains
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      @feature_files + @directories
    end


    private


    def scan_directory
      CucumberAnalytics::Logging.log_method("Directory##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      entries = Dir.entries(@directory)
      entries.delete '.'
      entries.delete '..'

      entries.each do |entry|
        entry = @directory + '/' + entry

        if File.directory?(entry)
          found_directory = Directory.new(entry)
          found_directory.parent_element = self

          @directories << found_directory
        end

        if entry =~ /\.feature$/
          found_feature_file = FeatureFile.new(entry)
          found_feature_file.parent_element = self

          @feature_files << found_feature_file
        end
      end
    end

  end
end
