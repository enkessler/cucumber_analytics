module CucumberAnalytics
  class ParsedDirectory


    attr_reader :feature_files
    attr_reader :feature_directories
    attr_accessor :parent_element


    # Creates a new ParsedDirectory object and, if *directory_parsed* is
    # provided, populates the object.
    def initialize(directory_parsed = nil)
      CucumberAnalytics::Logging.logger.info('ParsedDirectory#initialize')

      @directory = directory_parsed

      @feature_files = []
      @feature_directories = []

      scan_directory if directory_parsed
    end

    # Returns the name of the directory.
    def name
      File.basename(@directory.gsub('\\', '/'))
    end

    # Returns the path of the directory.
    def path
      @directory
    end

    # Returns the number of sub-directories contained in the directory.
    def directory_count
      @feature_directories.count
    end

    # Returns the number of features files contained in the directory.
    def feature_file_count
      @feature_files.count
    end

    # Returns the immediate child elements of the directory (i.e. its .feature
    # files and .feature file containing sub-directories).
    def contains
      @feature_files + @feature_directories
    end


    private


    def scan_directory
      entries = Dir.entries(@directory)
      entries.delete '.'
      entries.delete '..'

      entries.each do |entry|
        entry = @directory + '/' + entry

        if File.directory?(entry)
          found_directory = ParsedDirectory.new(entry)
          found_directory.parent_element = self

          @feature_directories << found_directory
        end

        @feature_files << ParsedFile.new(entry) if entry =~ /\.feature$/
      end
    end

  end
end
