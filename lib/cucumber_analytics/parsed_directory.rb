module CucumberAnalytics
  class ParsedDirectory


    attr_reader :feature_files
    attr_reader :feature_directories


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

    # Returns the number of features files contained in the directory.
    def feature_file_count
      @feature_files.count
    end

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
        @feature_directories << ParsedDirectory.new(entry) if File.directory?(entry)
        @feature_files << ParsedFile.new(entry) if entry =~ /\.feature$/
      end
    end

  end
end
